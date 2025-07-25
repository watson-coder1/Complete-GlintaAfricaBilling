<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * This file is part of the PEAR2\Console\CommandLine package.
 *
 * PHP version 5
 *
 * LICENSE: This source file is subject to the MIT license that is available
 * through the world-wide-web at the following URI:
 * http://opensource.org/licenses/mit-license.php
 *
 * @category  Console
 * @package   PEAR2\Console\CommandLine
 * @author    David JEAN LOUIS <izimobil@gmail.com>
 * @copyright 2007-2009 David JEAN LOUIS
 * @license   http://opensource.org/licenses/mit-license.php MIT License
 * @version   0.2.3
 * @link      http://pear2.php.net/PEAR2_Console_CommandLine
 * @since     File available since release 0.1.0
 *
 * @filesource
 */

namespace PEAR2\Console\CommandLine;

/**
 * Class that represent a command line element (an option, or an argument).
 *
 * @category  Console
 * @package   PEAR2\Console\CommandLine
 * @author    David JEAN LOUIS <izimobil@gmail.com>
 * @copyright 2007-2009 David JEAN LOUIS
 * @license   http://opensource.org/licenses/mit-license.php MIT License
 * @link      http://pear2.php.net/PEAR2_Console_CommandLine
 * @since     Class available since release 0.1.0
 */
abstract class Element
{
    // Public properties {{{

    /**
     * The element name.
     *
     * @var string $name Element name
     */
    public $name;

    /**
     * The name of variable displayed in the usage message, if no set it
     * defaults to the "name" property.
     *
     * @var string $help_name Element "help" variable name
     */
    public $help_name;

    /**
     * The element description.
     *
     * @var string $description Element description
     */
    public $description;
     /**
     * The default value of the element if not provided on the command line.
     *
     * @var mixed $default Default value of the option.
     */
    public $default;

    /**
     * Custom errors messages for this element
     *
     * This array is of the form:
     * <code>
     * <?php
     * array(
     *     $messageName => $messageText,
     *     $messageName => $messageText,
     *     ...
     * );
     * ?>
     * </code>
     *
     * If specified, these messages override the messages provided by the
     * default message provider. For example:
     * <code>
     * <?php
     * $messages = array(
     *     'ARGUMENT_REQUIRED' => 'The argument foo is required.',
     * );
     * ?>
     * </code>
     *
     * @var array
     * @see PEAR2\Console\CommandLine_MessageProvider\DefaultProvider
     */
    public $messages = array();

    // }}}
    // __construct() {{{

    /**
     * Constructor.
     *
     * @param string $name   The name of the element
     * @param array  $params An optional array of parameters
     *
     * @return void
     */
    public function __construct($name = null, $params = array())
    {
        $this->name = $name;
        foreach ($params as $attr => $value) {
            if (property_exists($this, $attr)) {
                $this->$attr = $value;
            }
        }
    }

    // }}}
    // toString() {{{

    /**
     * Returns the string representation of the element.
     *
     * @return string The string representation of the element
     *
     * @todo use __toString() instead
     */
    public function toString()
    {
        return $this->help_name;
    }
    // }}}
    // validate() {{{

    /**
     * Validates the element instance and set it's default values.
     *
     * @return void
     * @throws PEAR2\Console\CommandLine\Exception
     */
    public function validate()
    {
        // if no help_name passed, default to name
        if ($this->help_name == null) {
            $this->help_name = $this->name;
        }
    }

    // }}}
}
