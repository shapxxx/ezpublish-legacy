<?php
//
// Definition of eZSMTPTransport class
//
// Created on: <10-Dec-2002 15:20:20 amos>
//
// Copyright (C) 1999-2002 eZ systems as. All rights reserved.
//
// This source file is part of the eZ publish (tm) Open Source Content
// Management System.
//
// This file may be distributed and/or modified under the terms of the
// "GNU General Public License" version 2 as published by the Free
// Software Foundation and appearing in the file LICENSE.GPL included in
// the packaging of this file.
//
// Licencees holding valid "eZ publish professional licences" may use this
// file in accordance with the "eZ publish professional licence" Agreement
// provided with the Software.
//
// This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING
// THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE.
//
// The "eZ publish professional licence" is available at
// http://ez.no/home/licences/professional/. For pricing of this licence
// please contact us via e-mail to licence@ez.no. Further contact
// information is available at http://ez.no/home/contact/.
//
// The "GNU General Public License" (GPL) is available at
// http://www.gnu.org/copyleft/gpl.html.
//
// Contact licence@ez.no if any conditions of this licencing isn't clear to
// you.
//

/*! \file ezsmtptransport.php
*/

/*!
  \class eZSMTPTransport ezsmtptransport.php
  \brief The class eZSMTPTransport does

*/

include_once( 'lib/ezutils/classes/ezmailtransport.php' );

class eZSMTPTransport extends eZMailTransport
{
    /*!
     Constructor
    */
    function eZSMTPTransport()
    {
    }

    /*!
     \reimp
    */
    function sendMail( &$mail )
    {
        $ini =& eZINI::instance();
        $parameters = array();
        $parameters['host'] = $ini->variable( 'MailSettings', 'TransportServer' );
        $parameters['port'] = $ini->variable( 'MailSettings', 'TransportPort' );
        $user = $ini->variable( 'MailSettings', 'TransportUser' );
        $password = $ini->variable( 'MailSettings', 'TransportPassword' );
        if ( $user and
             $password )
        {
            $parameters['auth'] = true;
            $parameters['user'] = $user;
            $parameters['password'] = $password;
        }

        $sendData = array();
        $sendData['from'] = $mail->senderText();
        $sendData["recipients"] = $mail->receiverTextList();
        $sendData['headers'] = $mail->headerTextList();
        $sendData['body'] = $mail->body();

        include_once( "lib/ezutils/classes/ezsmtp.php" );

        $smtp = smtp::connect( $parameters );
        if ( $smtp )
        {
            $result = $smtp->send( $sendData );
            $mailSent = true;
            if ( isset( $smtp->errors[0] ) )
            {
                eZDebug::writeError( "Error sending SMTP mail: " . $smtp->errors[0], "eZSMTPTransport::sendMail()" );
                $mailSent = false;
            }
            $smtp->quit();
        }
        else
            $mailSent = false;
        return $mailSent;
    }
}

?>
