/**
 * Auto-Fill System - Saves form data as you type and restores it when you return
 * Prevents data loss when users accidentally navigate away or browser crashes
 */

(function() {
    'use strict';

    // Configuration
    const AUTO_FILL_CONFIG = {
        saveInterval: 2000, // Save every 2 seconds
        maxStorageAge: 7 * 24 * 60 * 60 * 1000, // 7 days in milliseconds
        maxStorageItems: 50, // Maximum number of forms to remember
        storagePrefix: 'glinta_autofill_',
        excludeFields: [
            'password', 'passwd', 'pass', 'pwd',
            'token', 'csrf', '_token', 'csrf_token',
            'credit_card', 'card_number', 'cvv', 'ssn',
            'api_key', 'secret', 'private_key'
        ],
        excludeTypes: ['password', 'hidden'],
        includedPages: [
            'pages', 'customers', 'admin', 'settings', 
            'plan', 'router', 'bandwidth', 'voucher',
            'paymentgateway', 'message', 'reports'
        ]
    };

    // State management
    let autoFillEnabled = true;
    let saveTimer = null;
    let currentFormData = {};
    let hasUnsavedChanges = false;
    let formIdentifier = '';

    // Initialize the auto-fill system
    function initAutoFillSystem() {
        // Check if we're on a relevant page
        if (!isRelevantPage()) {
            return;
        }

        // Generate form identifier
        formIdentifier = generateFormIdentifier();
        
        // Clean old data first
        cleanOldStorageData();
        
        // Setup form monitoring
        setupFormMonitoring();
        
        // Restore saved data if available
        restoreSavedData();
        
        // Setup auto-save
        setupAutoSave();
        
        // Add UI indicators
        addAutoFillUI();
        
        // Setup before unload warning
        setupBeforeUnloadProtection();
        
        console.log('Auto-fill system initialized for:', formIdentifier);
    }

    function isRelevantPage() {
        const currentPath = window.location.pathname;
        return AUTO_FILL_CONFIG.includedPages.some(page => currentPath.includes(page));
    }

    function generateFormIdentifier() {
        const path = window.location.pathname;
        const params = new URLSearchParams(window.location.search);
        const route = params.get('_route') || 'default';
        
        // Create unique identifier for this form/page
        return `${path}_${route}`.replace(/[^a-zA-Z0-9_]/g, '_');
    }

    function setupFormMonitoring() {
        // Find all relevant form elements
        const formElements = document.querySelectorAll(`
            input[type="text"], 
            input[type="email"], 
            input[type="tel"], 
            input[type="url"], 
            input[type="number"],
            input[type="date"],
            input[type="time"],
            input[type="datetime-local"],
            textarea, 
            select,
            input[type="radio"]:checked,
            input[type="checkbox"]
        `);

        formElements.forEach(element => {
            if (shouldMonitorElement(element)) {
                // Monitor changes
                element.addEventListener('input', handleFormChange);
                element.addEventListener('change', handleFormChange);
                element.addEventListener('blur', handleFormChange);
                
                // Add visual indicator
                addFieldIndicator(element);
            }
        });

        // Special handling for rich text editors
        monitorRichTextEditors();
    }

    function shouldMonitorElement(element) {
        // Skip if disabled or readonly
        if (element.disabled || element.readOnly) {
            return false;
        }

        // Skip excluded types
        if (AUTO_FILL_CONFIG.excludeTypes.includes(element.type)) {
            return false;
        }

        // Skip excluded field names
        const fieldName = (element.name || element.id || '').toLowerCase();
        if (AUTO_FILL_CONFIG.excludeFields.some(excluded => fieldName.includes(excluded))) {
            return false;
        }

        // Skip if explicitly marked to exclude
        if (element.hasAttribute('data-no-autofill') || element.hasAttribute('autocomplete') && element.getAttribute('autocomplete') === 'off') {
            return false;
        }

        return true;
    }

    function monitorRichTextEditors() {
        // Monitor Summernote editors
        if (typeof $ !== 'undefined' && $.fn.summernote) {
            $('#summernote').on('summernote.change', function() {
                handleFormChange({ target: this });
            });
        }

        // Monitor other common editors
        const textareas = document.querySelectorAll('textarea');
        textareas.forEach(textarea => {
            if (textarea.id === 'summernote' || textarea.classList.contains('editor')) {
                // For rich text editors, also monitor direct value changes
                let lastValue = textarea.value;
                setInterval(() => {
                    if (textarea.value !== lastValue) {
                        lastValue = textarea.value;
                        handleFormChange({ target: textarea });
                    }
                }, 1000);
            }
        });
    }

    function handleFormChange(event) {
        if (!autoFillEnabled) return;

        hasUnsavedChanges = true;
        
        // Update field indicator
        updateFieldIndicator(event.target, 'unsaved');
        
        // Debounce the save operation
        clearTimeout(saveTimer);
        saveTimer = setTimeout(() => {
            saveFormData();
        }, AUTO_FILL_CONFIG.saveInterval);
    }

    function saveFormData() {
        if (!autoFillEnabled) return;

        const formData = collectFormData();
        
        if (Object.keys(formData).length === 0) {
            return;
        }

        const saveData = {
            data: formData,
            timestamp: Date.now(),
            url: window.location.href,
            formId: formIdentifier,
            pageTitle: document.title
        };

        try {
            const storageKey = AUTO_FILL_CONFIG.storagePrefix + formIdentifier;
            localStorage.setItem(storageKey, JSON.stringify(saveData));
            
            // Update UI indicators
            updateAllFieldIndicators('saved');
            showSaveNotification('Form data auto-saved', 'success');
            
            console.log('Form data saved:', formIdentifier, Object.keys(formData).length, 'fields');
        } catch (error) {
            console.error('Failed to save form data:', error);
            showSaveNotification('Auto-save failed - storage full?', 'error');
        }
    }

    function collectFormData() {
        const data = {};
        
        // Regular form elements
        const elements = document.querySelectorAll(`
            input[type="text"], 
            input[type="email"], 
            input[type="tel"], 
            input[type="url"], 
            input[type="number"],
            input[type="date"],
            input[type="time"],
            input[type="datetime-local"],
            textarea, 
            select
        `);

        elements.forEach(element => {
            if (shouldMonitorElement(element) && element.value.trim() !== '') {
                const key = element.name || element.id;
                if (key) {
                    data[key] = element.value;
                }
            }
        });

        // Checkboxes and radio buttons
        const checkboxes = document.querySelectorAll('input[type="checkbox"]');
        checkboxes.forEach(checkbox => {
            if (shouldMonitorElement(checkbox)) {
                const key = checkbox.name || checkbox.id;
                if (key) {
                    data[key] = checkbox.checked;
                }
            }
        });

        const radios = document.querySelectorAll('input[type="radio"]:checked');
        radios.forEach(radio => {
            if (shouldMonitorElement(radio)) {
                const key = radio.name;
                if (key) {
                    data[key] = radio.value;
                }
            }
        });

        // Summernote content
        if (typeof $ !== 'undefined' && $('#summernote').length) {
            const summernoteContent = $('#summernote').summernote('code');
            if (summernoteContent && summernoteContent.trim() !== '') {
                data['summernote_content'] = summernoteContent;
            }
        }

        return data;
    }

    function restoreSavedData() {
        const storageKey = AUTO_FILL_CONFIG.storagePrefix + formIdentifier;
        
        try {
            const savedDataStr = localStorage.getItem(storageKey);
            if (!savedDataStr) {
                return;
            }

            const savedData = JSON.parse(savedDataStr);
            
            // Check if data is not too old
            const age = Date.now() - savedData.timestamp;
            if (age > AUTO_FILL_CONFIG.maxStorageAge) {
                localStorage.removeItem(storageKey);
                return;
            }

            // Show restoration notification
            showRestorationNotification(savedData, storageKey);
            
        } catch (error) {
            console.error('Failed to restore form data:', error);
        }
    }

    function showRestorationNotification(savedData, storageKey) {
        const restorationDiv = document.createElement('div');
        restorationDiv.className = 'auto-fill-restoration-notification';
        restorationDiv.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 5px;
            padding: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            z-index: 10000;
            max-width: 400px;
            font-family: inherit;
        `;

        const fieldCount = Object.keys(savedData.data).length;
        const timeAgo = formatTimeAgo(savedData.timestamp);

        restorationDiv.innerHTML = `
            <div style="display: flex; align-items: center; margin-bottom: 10px;">
                <i class="fa fa-history" style="color: #856404; margin-right: 8px;"></i>
                <strong style="color: #856404;">Form Data Found</strong>
            </div>
            <p style="margin: 5px 0; color: #856404; font-size: 14px;">
                Found ${fieldCount} saved field(s) from ${timeAgo}
            </p>
            <div style="margin-top: 10px;">
                <button onclick="window.autoFillRestore('${storageKey}')" class="btn btn-warning btn-sm" style="margin-right: 8px;">
                    <i class="fa fa-undo"></i> Restore Data
                </button>
                <button onclick="window.autoFillDiscard('${storageKey}')" class="btn btn-default btn-sm" style="margin-right: 8px;">
                    <i class="fa fa-times"></i> Discard
                </button>
                <button onclick="this.parentElement.parentElement.remove()" class="btn btn-link btn-sm">
                    Hide
                </button>
            </div>
        `;

        document.body.appendChild(restorationDiv);

        // Auto-hide after 30 seconds
        setTimeout(() => {
            if (restorationDiv.parentNode) {
                restorationDiv.remove();
            }
        }, 30000);
    }

    // Global functions for restoration buttons
    window.autoFillRestore = function(storageKey) {
        try {
            const savedDataStr = localStorage.getItem(storageKey);
            const savedData = JSON.parse(savedDataStr);
            
            restoreFormFields(savedData.data);
            
            // Remove notification
            const notification = document.querySelector('.auto-fill-restoration-notification');
            if (notification) notification.remove();
            
            showSaveNotification('Form data restored successfully!', 'success');
            
        } catch (error) {
            console.error('Failed to restore data:', error);
            showSaveNotification('Failed to restore form data', 'error');
        }
    };

    window.autoFillDiscard = function(storageKey) {
        localStorage.removeItem(storageKey);
        const notification = document.querySelector('.auto-fill-restoration-notification');
        if (notification) notification.remove();
        showSaveNotification('Saved form data discarded', 'info');
    };

    function restoreFormFields(data) {
        Object.entries(data).forEach(([key, value]) => {
            if (key === 'summernote_content') {
                // Restore Summernote content
                if (typeof $ !== 'undefined' && $('#summernote').length) {
                    $('#summernote').summernote('code', value);
                }
                return;
            }

            // Find element by name or id
            let element = document.querySelector(`[name="${key}"]`) || document.querySelector(`#${key}`);
            
            if (!element) return;

            if (element.type === 'checkbox') {
                element.checked = value;
            } else if (element.type === 'radio') {
                if (element.value === value) {
                    element.checked = true;
                }
            } else {
                element.value = value;
            }

            // Trigger change event
            element.dispatchEvent(new Event('change', { bubbles: true }));
            
            // Update field indicator
            updateFieldIndicator(element, 'restored');
        });
    }

    function addFieldIndicator(element) {
        // Skip if already has indicator
        if (element.nextElementSibling && element.nextElementSibling.classList.contains('auto-fill-indicator')) {
            return;
        }

        const indicator = document.createElement('span');
        indicator.className = 'auto-fill-indicator';
        indicator.style.cssText = `
            display: inline-block;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #bdc3c7;
            margin-left: 5px;
            vertical-align: middle;
            transition: background-color 0.3s ease;
        `;
        indicator.title = 'Auto-fill status';

        // Insert after the element
        if (element.parentNode) {
            element.parentNode.insertBefore(indicator, element.nextSibling);
        }
    }

    function updateFieldIndicator(element, status) {
        const indicator = element.nextElementSibling;
        if (!indicator || !indicator.classList.contains('auto-fill-indicator')) {
            return;
        }

        switch (status) {
            case 'unsaved':
                indicator.style.background = '#f39c12';
                indicator.title = 'Unsaved changes';
                break;
            case 'saved':
                indicator.style.background = '#27ae60';
                indicator.title = 'Auto-saved';
                break;
            case 'restored':
                indicator.style.background = '#3498db';
                indicator.title = 'Restored from auto-save';
                break;
            default:
                indicator.style.background = '#bdc3c7';
                indicator.title = 'Auto-fill status';
        }
    }

    function updateAllFieldIndicators(status) {
        document.querySelectorAll('.auto-fill-indicator').forEach(indicator => {
            updateFieldIndicator(indicator.previousElementSibling, status);
        });
    }

    function setupAutoSave() {
        // Save form data periodically
        setInterval(() => {
            if (hasUnsavedChanges && autoFillEnabled) {
                saveFormData();
                hasUnsavedChanges = false;
            }
        }, AUTO_FILL_CONFIG.saveInterval);
    }

    function addAutoFillUI() {
        // Add auto-fill control panel
        const controlPanel = document.createElement('div');
        controlPanel.id = 'autoFillControlPanel';
        controlPanel.style.cssText = `
            position: fixed;
            bottom: 20px;
            left: 20px;
            background: white;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            z-index: 1000;
            font-size: 12px;
            min-width: 200px;
        `;

        controlPanel.innerHTML = `
            <div style="display: flex; align-items: center; justify-content: space-between;">
                <span>
                    <i class="fa fa-magic"></i> Auto-fill: 
                    <span id="autoFillStatus" style="font-weight: bold;">ON</span>
                </span>
                <button id="toggleAutoFill" class="btn btn-xs btn-default">
                    <i class="fa fa-toggle-on"></i>
                </button>
            </div>
            <div style="margin-top: 5px; font-size: 11px; color: #666;">
                <span id="fieldCount">0</span> fields monitored
            </div>
        `;

        document.body.appendChild(controlPanel);

        // Setup toggle functionality
        const toggleButton = document.getElementById('toggleAutoFill');
        const statusSpan = document.getElementById('autoFillStatus');

        toggleButton.addEventListener('click', () => {
            autoFillEnabled = !autoFillEnabled;
            statusSpan.textContent = autoFillEnabled ? 'ON' : 'OFF';
            statusSpan.style.color = autoFillEnabled ? '#27ae60' : '#e74c3c';
            toggleButton.innerHTML = autoFillEnabled ? '<i class="fa fa-toggle-on"></i>' : '<i class="fa fa-toggle-off"></i>';
            
            // Save preference
            localStorage.setItem('autoFillEnabled', autoFillEnabled);
            
            showSaveNotification(`Auto-fill ${autoFillEnabled ? 'enabled' : 'disabled'}`, 'info');
        });

        // Load saved preference
        const savedPreference = localStorage.getItem('autoFillEnabled');
        if (savedPreference !== null) {
            autoFillEnabled = savedPreference === 'true';
            statusSpan.textContent = autoFillEnabled ? 'ON' : 'OFF';
            statusSpan.style.color = autoFillEnabled ? '#27ae60' : '#e74c3c';
            toggleButton.innerHTML = autoFillEnabled ? '<i class="fa fa-toggle-on"></i>' : '<i class="fa fa-toggle-off"></i>';
        }

        // Update field count
        updateFieldCount();
    }

    function updateFieldCount() {
        const monitoredFields = document.querySelectorAll('.auto-fill-indicator').length;
        const fieldCountSpan = document.getElementById('fieldCount');
        if (fieldCountSpan) {
            fieldCountSpan.textContent = monitoredFields;
        }
    }

    function setupBeforeUnloadProtection() {
        window.addEventListener('beforeunload', (e) => {
            if (hasUnsavedChanges && autoFillEnabled) {
                // Save immediately before leaving
                saveFormData();
                
                const message = 'You have unsaved changes. They will be auto-saved and available when you return.';
                e.returnValue = message;
                return message;
            }
        });
    }

    function cleanOldStorageData() {
        const keysToRemove = [];
        const now = Date.now();

        for (let i = 0; i < localStorage.length; i++) {
            const key = localStorage.key(i);
            if (key && key.startsWith(AUTO_FILL_CONFIG.storagePrefix)) {
                try {
                    const data = JSON.parse(localStorage.getItem(key));
                    const age = now - data.timestamp;
                    
                    if (age > AUTO_FILL_CONFIG.maxStorageAge) {
                        keysToRemove.push(key);
                    }
                } catch (error) {
                    // Remove corrupted data
                    keysToRemove.push(key);
                }
            }
        }

        // Remove old data
        keysToRemove.forEach(key => localStorage.removeItem(key));
        
        if (keysToRemove.length > 0) {
            console.log(`Cleaned ${keysToRemove.length} old auto-fill entries`);
        }
    }

    function showSaveNotification(message, type) {
        const notification = document.createElement('div');
        notification.className = `auto-fill-notification alert alert-${type === 'error' ? 'danger' : type === 'success' ? 'success' : 'info'}`;
        notification.style.cssText = `
            position: fixed;
            top: 60px;
            right: 20px;
            z-index: 9999;
            min-width: 250px;
            opacity: 0.95;
            font-size: 12px;
        `;
        notification.innerHTML = `
            <i class="fa fa-${type === 'error' ? 'exclamation-triangle' : type === 'success' ? 'check' : 'info-circle'}"></i>
            ${message}
        `;
        
        document.body.appendChild(notification);
        
        // Auto-remove after 3 seconds
        setTimeout(() => {
            if (notification.parentNode) {
                notification.style.opacity = '0';
                setTimeout(() => notification.remove(), 300);
            }
        }, 3000);
    }

    function formatTimeAgo(timestamp) {
        const now = Date.now();
        const diff = now - timestamp;
        
        const minutes = Math.floor(diff / 60000);
        const hours = Math.floor(diff / 3600000);
        const days = Math.floor(diff / 86400000);
        
        if (days > 0) return `${days} day${days > 1 ? 's' : ''} ago`;
        if (hours > 0) return `${hours} hour${hours > 1 ? 's' : ''} ago`;
        if (minutes > 0) return `${minutes} minute${minutes > 1 ? 's' : ''} ago`;
        return 'just now';
    }

    // Public API for manual control
    window.AutoFillSystem = {
        save: saveFormData,
        restore: restoreSavedData,
        clear: () => {
            const storageKey = AUTO_FILL_CONFIG.storagePrefix + formIdentifier;
            localStorage.removeItem(storageKey);
            showSaveNotification('Auto-fill data cleared', 'info');
        },
        toggle: () => {
            autoFillEnabled = !autoFillEnabled;
            showSaveNotification(`Auto-fill ${autoFillEnabled ? 'enabled' : 'disabled'}`, 'info');
        }
    };

    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initAutoFillSystem);
    } else {
        initAutoFillSystem();
    }

})();