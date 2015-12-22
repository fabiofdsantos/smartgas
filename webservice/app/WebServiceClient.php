<?php

/*
 * This file is part of SmartGas, an iOS app to find the best gas station nearby.
 *
 * (c) Fábio Santos <ffsantos92@gmail.com>
 * (c) Mateus Silva <mateusgsilva_@hotmail.com>
 * (c) Fábio Marques <fabio1956.epo@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace App;

class WebServiceClient extends \SoapClient
{
    /**
     * The username used in authentication.
     */
    const USERNAME = 'username';

    /**
     * The password used in authentication.
     */
    const PASSWORD = 'password';

    /**
     * Override the __soapCall method for using a specific header.
     *
     * @param string $function
     * @param array  $arguments
     * @param array  $options
     * @param mixed  $input_headers
     * @param array  $output_headers
     *
     * @see http://php.net/manual/en/soapclient.soapcall.php
     *
     * @return mixed
     */
    public function __soapCall($function_name, $arguments, $options = null, $input_headers, &$output_headers = null)
    {
        return parent::__soapCall($function_name, $arguments, $options, self::getHeader());
    }

    /**
     * Generate a header to be used in __soapCall.
     * The header follows the SOAP Message Security 1.0 (WS-Security 2004).
     *
     * Notes:
     *  - XSD_ANYXML constant can be used to provide an input parameter as a
     *  raw XML string. See http://php.net/manual/en/soap.constants.php
     *
     *  @link http://php.net/manual/en/soap.constants.php
     *  @see http://php.net/manual/en/soapclient.setsoapheaders.php
     *
     * @return \SoapHeader
     */
    public static function getHeader()
    {
        $xml = '<wsse:Security soapenv:mustUnderstand="1" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">';
        $xml .= '<wsse:UsernameToken wsu:Id="UsernameToken-2" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">';
        $xml .= '<wsse:Username>'.self::USERNAME.'</wsse:Username>';
        $xml .= '<wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">'.self::PASSWORD.'</wsse:Password>';
        // TODO - Fix the following line:
        //$xml .= '<wsse:Nonce EncodingType="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-soap-message-security-1.0#Base64Binary">'.base64_encode('').'</wsse:Nonce>';
        $xml .= '<wsu:Created>'.gmdate("Y-m-d\TH:i:s\Z").'</wsu:Created>';
        $xml .= '</wsse:UsernameToken>';
        $xml .= '</wsse:Security>';

        return new \SoapHeader(
            'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', // namespace
            'Security', // name
            new \SoapVar($xml, XSD_ANYXML) // data
        );
    }
}
