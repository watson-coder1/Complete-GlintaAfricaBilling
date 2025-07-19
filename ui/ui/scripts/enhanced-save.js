/**
 * Enhanced Save Functionality with Progress Indicators and Timeout Handling
 * Prevents timeout errors and provides better user feedback
 */

(function() {
    'use strict';

    // Configuration
    const SAVE_CONFIG = {
        timeout: 45000, // 45 seconds (less than nginx timeout)
        retryAttempts: 3,
        retryDelay: 2000,
        autoSaveInterval: 30000, // Auto-save every 30 seconds
        progressUpdateInterval: 500
    };

    // State management
    let saveInProgress = false;
    let autoSaveTimer = null;
    let currentSaveAttempt = 0;
    let lastSaveContent = '';

    // Initialize enhanced save functionality
    function initEnhancedSave() {
        // Override form submission
        enhanceFormSubmission();
        
        // Add save progress indicator
        addSaveProgressIndicator();
        
        // Setup auto-save
        setupAutoSave();
        
        // Add keyboard shortcuts
        addKeyboardShortcuts();
        
        // Setup beforeunload warning
        setupBeforeUnloadWarning();
    }

    function enhanceFormSubmission() {
        const forms = document.querySelectorAll('form[id*="form"], form[action*="post"]');
        
        forms.forEach(form => {
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                handleSaveAttempt(this);
            });
        });
    }

    function addSaveProgressIndicator() {
        // Create progress modal
        const progressModal = `
            <div id="saveProgressModal" class="modal fade" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">
                                <i class="fa fa-spinner fa-spin"></i> Saving...
                            </h4>
                        </div>
                        <div class="modal-body text-center">
                            <div class="progress" style="margin-bottom: 15px;">
                                <div id="saveProgressBar" class="progress-bar progress-bar-striped active" 
                                     role="progressbar" style="width: 0%"></div>
                            </div>
                            <p id="saveProgressText">Preparing to save...</p>
                            <div id="saveActions" style="display: none; margin-top: 15px;">
                                <button id="retrySave" class="btn btn-primary btn-sm">
                                    <i class="fa fa-refresh"></i> Retry
                                </button>
                                <button id="cancelSave" class="btn btn-default btn-sm">
                                    <i class="fa fa-times"></i> Cancel
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>`;
        
        document.body.insertAdjacentHTML('beforeend', progressModal);
    }

    function setupAutoSave() {
        // Find content areas that should be auto-saved
        const autoSaveElements = document.querySelectorAll('#summernote, textarea[name="html"], input[name*="content"]');
        
        if (autoSaveElements.length > 0) {
            autoSaveTimer = setInterval(() => {
                if (!saveInProgress) {
                    performAutoSave();
                }
            }, SAVE_CONFIG.autoSaveInterval);
        }
    }

    function addKeyboardShortcuts() {
        document.addEventListener('keydown', function(e) {
            // Ctrl+S or Cmd+S
            if ((e.ctrlKey || e.metaKey) && e.key === 's') {
                e.preventDefault();
                const form = document.querySelector('form[id*="form"], form[action*="post"]');
                if (form) {
                    handleSaveAttempt(form);
                }
            }
        });
    }

    function setupBeforeUnloadWarning() {
        let contentChanged = false;
        
        // Monitor content changes
        const monitorElements = document.querySelectorAll('#summernote, textarea[name="html"], input[type="text"]');
        
        monitorElements.forEach(element => {
            element.addEventListener('input', () => {
                contentChanged = true;
                lastSaveContent = getCurrentContent();
            });
        });

        window.addEventListener('beforeunload', function(e) {
            if (contentChanged && !saveInProgress) {
                const message = 'You have unsaved changes. Are you sure you want to leave?';
                e.returnValue = message;
                return message;
            }
        });
    }

    function handleSaveAttempt(form) {
        if (saveInProgress) {
            showUserMessage('Save already in progress. Please wait...', 'warning');
            return;
        }

        currentSaveAttempt = 1;
        performSave(form);
    }

    function performSave(form) {
        saveInProgress = true;
        showSaveProgress();
        
        const formData = new FormData(form);
        const startTime = Date.now();
        
        // Create timeout handler
        const timeoutHandler = setTimeout(() => {
            handleSaveTimeout(form);
        }, SAVE_CONFIG.timeout);

        // Update progress
        let progress = 0;
        const progressUpdater = setInterval(() => {
            progress = Math.min(90, (Date.now() - startTime) / SAVE_CONFIG.timeout * 100);
            updateSaveProgress(progress, `Saving... (Attempt ${currentSaveAttempt})`);
        }, SAVE_CONFIG.progressUpdateInterval);

        // Perform the actual save
        fetch(form.action, {
            method: 'POST',
            body: formData,
            credentials: 'same-origin'
        })
        .then(response => {
            clearTimeout(timeoutHandler);
            clearInterval(progressUpdater);
            
            if (response.ok) {
                return response.text();
            } else {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }
        })
        .then(data => {
            updateSaveProgress(100, 'Save completed successfully!');
            
            setTimeout(() => {
                hideSaveProgress();
                saveInProgress = false;
                
                // Check if response contains error
                if (data.includes('error') || data.includes('failed')) {
                    showUserMessage('Save completed with warnings. Please check the result.', 'warning');
                } else {
                    showUserMessage('Content saved successfully!', 'success');
                }
                
                // Redirect if successful
                if (data.includes('_route=') || data.includes('success')) {
                    window.location.reload();
                }
            }, 1000);
        })
        .catch(error => {
            clearTimeout(timeoutHandler);
            clearInterval(progressUpdater);
            
            console.error('Save error:', error);
            handleSaveError(form, error.message);
        });
    }

    function handleSaveTimeout(form) {
        updateSaveProgress(50, 'Save is taking longer than expected...');
        
        // Show user options instead of just failing
        showTimeoutOptions(form);
    }

    function handleSaveError(form, errorMessage) {
        updateSaveProgress(0, 'Save failed: ' + errorMessage);
        
        if (currentSaveAttempt < SAVE_CONFIG.retryAttempts) {
            showRetryOptions(form);
        } else {
            showFinalErrorOptions(form, errorMessage);
        }
    }

    function showTimeoutOptions(form) {
        const progressText = document.getElementById('saveProgressText');
        const actions = document.getElementById('saveActions');
        
        progressText.innerHTML = `
            <strong>Save is taking longer than expected.</strong><br>
            This might be due to server load or network issues.<br>
            <small>Your content is preserved and safe.</small>
        `;
        
        actions.style.display = 'block';
        
        // Setup retry button
        document.getElementById('retrySave').onclick = () => {
            hideUserActions();
            currentSaveAttempt++;
            performSave(form);
        };
        
        // Setup cancel button
        document.getElementById('cancelSave').onclick = () => {
            saveInProgress = false;
            hideSaveProgress();
            showUserMessage('Save cancelled. Your changes are preserved in the editor.', 'info');
        };
    }

    function showRetryOptions(form) {
        const progressText = document.getElementById('saveProgressText');
        const actions = document.getElementById('saveActions');
        
        progressText.innerHTML = `
            <strong>Save failed (Attempt ${currentSaveAttempt}/${SAVE_CONFIG.retryAttempts})</strong><br>
            Would you like to try again?<br>
            <small>Your content is safe and preserved.</small>
        `;
        
        actions.style.display = 'block';
        
        document.getElementById('retrySave').onclick = () => {
            hideUserActions();
            currentSaveAttempt++;
            setTimeout(() => performSave(form), SAVE_CONFIG.retryDelay);
        };
        
        document.getElementById('cancelSave').onclick = () => {
            saveInProgress = false;
            hideSaveProgress();
            showUserMessage('Save cancelled. Please try again later or contact support.', 'warning');
        };
    }

    function showFinalErrorOptions(form, errorMessage) {
        const progressText = document.getElementById('saveProgressText');
        const actions = document.getElementById('saveActions');
        
        progressText.innerHTML = `
            <strong>Unable to save after ${SAVE_CONFIG.retryAttempts} attempts</strong><br>
            ${errorMessage}<br>
            <small>Your content is preserved. You can:</small>
        `;
        
        // Replace actions with more options
        actions.innerHTML = `
            <button id="copyContent" class="btn btn-info btn-sm">
                <i class="fa fa-copy"></i> Copy Content
            </button>
            <button id="downloadContent" class="btn btn-success btn-sm">
                <i class="fa fa-download"></i> Download
            </button>
            <button id="finalRetry" class="btn btn-warning btn-sm">
                <i class="fa fa-refresh"></i> Try Once More
            </button>
            <button id="closeModal" class="btn btn-default btn-sm">
                <i class="fa fa-times"></i> Close
            </button>
        `;
        
        actions.style.display = 'block';
        
        // Setup action handlers
        setupFinalErrorActions(form);
    }

    function setupFinalErrorActions(form) {
        document.getElementById('copyContent').onclick = () => {
            const content = getCurrentContent();
            copyToClipboard(content);
            showUserMessage('Content copied to clipboard!', 'success');
        };
        
        document.getElementById('downloadContent').onclick = () => {
            const content = getCurrentContent();
            downloadContent(content, 'saved-content.html');
            showUserMessage('Content downloaded as file!', 'success');
        };
        
        document.getElementById('finalRetry').onclick = () => {
            hideUserActions();
            currentSaveAttempt = 1;
            performSave(form);
        };
        
        document.getElementById('closeModal').onclick = () => {
            saveInProgress = false;
            hideSaveProgress();
        };
    }

    function performAutoSave() {
        const currentContent = getCurrentContent();
        
        if (currentContent && currentContent !== lastSaveContent && currentContent.trim() !== '') {
            console.log('Performing auto-save...');
            
            // Create a simple save without UI disruption
            const form = document.querySelector('form[id*="form"], form[action*="post"]');
            if (form) {
                const formData = new FormData(form);
                
                fetch(form.action, {
                    method: 'POST',
                    body: formData,
                    credentials: 'same-origin'
                })
                .then(response => {
                    if (response.ok) {
                        lastSaveContent = currentContent;
                        showTemporaryMessage('Auto-saved', 'success', 2000);
                    }
                })
                .catch(error => {
                    console.log('Auto-save failed:', error);
                });
            }
        }
    }

    // Utility functions
    function getCurrentContent() {
        const summernote = document.getElementById('summernote');
        if (summernote) {
            return summernote.value || '';
        }
        
        const htmlTextarea = document.querySelector('textarea[name="html"]');
        if (htmlTextarea) {
            return htmlTextarea.value || '';
        }
        
        return '';
    }

    function showSaveProgress() {
        const modal = document.getElementById('saveProgressModal');
        if (modal && typeof $ !== 'undefined') {
            $(modal).modal('show');
        }
    }

    function hideSaveProgress() {
        const modal = document.getElementById('saveProgressModal');
        if (modal && typeof $ !== 'undefined') {
            $(modal).modal('hide');
        }
    }

    function updateSaveProgress(percentage, text) {
        const progressBar = document.getElementById('saveProgressBar');
        const progressText = document.getElementById('saveProgressText');
        
        if (progressBar) {
            progressBar.style.width = percentage + '%';
        }
        
        if (progressText) {
            progressText.textContent = text;
        }
    }

    function hideUserActions() {
        const actions = document.getElementById('saveActions');
        if (actions) {
            actions.style.display = 'none';
        }
    }

    function showUserMessage(message, type) {
        // Use existing notification system if available
        if (typeof Swal !== 'undefined') {
            Swal.fire({
                title: type === 'success' ? 'Success' : type === 'warning' ? 'Warning' : 'Information',
                text: message,
                icon: type === 'success' ? 'success' : type === 'warning' ? 'warning' : 'info',
                timer: 4000,
                showConfirmButton: false
            });
        } else {
            alert(message);
        }
    }

    function showTemporaryMessage(message, type, duration) {
        const notification = document.createElement('div');
        notification.className = `alert alert-${type} auto-save-notification`;
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            min-width: 200px;
            opacity: 0.9;
        `;
        notification.textContent = message;
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            if (notification.parentNode) {
                notification.parentNode.removeChild(notification);
            }
        }, duration);
    }

    function copyToClipboard(text) {
        const textarea = document.createElement('textarea');
        textarea.value = text;
        document.body.appendChild(textarea);
        textarea.select();
        document.execCommand('copy');
        document.body.removeChild(textarea);
    }

    function downloadContent(content, filename) {
        const blob = new Blob([content], { type: 'text/html' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = filename;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
    }

    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initEnhancedSave);
    } else {
        initEnhancedSave();
    }

})();