// Daraja URL Field Fix
// This script ensures callback and timeout URL fields are editable

(function() {
    'use strict';
    
    console.log('🔧 Daraja URL Fix Script Loaded');
    
    function enableUrlFields() {
        // Try multiple selectors
        var selectors = [
            'input[name="callback_url"]',
            'input[name="timeout_url"]',
            '#callback_url',
            '#timeout_url',
            'input[name="daraja_callback_url"]',
            'input[name="daraja_timeout_url"]'
        ];
        
        selectors.forEach(function(selector) {
            var elements = document.querySelectorAll(selector);
            elements.forEach(function(el) {
                if (el) {
                    console.log('Found field:', selector, el);
                    el.removeAttribute('readonly');
                    el.removeAttribute('disabled');
                    el.readOnly = false;
                    el.disabled = false;
                    el.style.backgroundColor = '#ffffff';
                    el.style.cursor = 'text';
                    
                    // Remove any event listeners that might block input
                    var newEl = el.cloneNode(true);
                    el.parentNode.replaceChild(newEl, el);
                    
                    console.log('✅ Enabled field:', selector);
                }
            });
        });
    }
    
    // Run immediately
    enableUrlFields();
    
    // Run when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', enableUrlFields);
    }
    
    // Run after a delay to catch any late modifications
    setTimeout(enableUrlFields, 100);
    setTimeout(enableUrlFields, 500);
    setTimeout(enableUrlFields, 1000);
    
    // Add click handler to force enable on click
    document.addEventListener('click', function(e) {
        if (e.target && (e.target.name === 'callback_url' || e.target.name === 'timeout_url')) {
            e.target.readOnly = false;
            e.target.disabled = false;
            console.log('Click detected, enabling field:', e.target.name);
        }
    });
    
})();