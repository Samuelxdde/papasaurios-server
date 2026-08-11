package Controlador;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EnviarCorreo {

    public static boolean enviar(String destinatario, String asunto, String cuerpo) {
        // El correo remitente y la contraseña de aplicación de Gmail NUNCA
        // van escritos en el código (si este archivo se sube a GitHub, esa
        // contraseña queda expuesta en el historial para siempre). Se leen
        // como variables de entorno, que hay que configurar a mano en
        // Railway (servicio del backend → Variables): GMAIL_USER y
        // GMAIL_APP_PASSWORD.
        String usuarioGmail = System.getenv("GMAIL_USER");
        String claveApp = System.getenv("GMAIL_APP_PASSWORD");

        if (usuarioGmail == null || claveApp == null) {
            System.err.println("EnviarCorreo: faltan las variables de entorno "
                    + "GMAIL_USER / GMAIL_APP_PASSWORD, no se puede enviar el correo.");
            return false;
        }

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(usuarioGmail, claveApp);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(usuarioGmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            message.setSubject(asunto);
            message.setText(cuerpo);

            Transport.send(message);
            System.out.println("Correo enviado correctamente a " + destinatario);
            return true;
        } catch (MessagingException e) {
            System.err.println("EnviarCorreo: fallo al enviar a " + destinatario + " -> " + e.getMessage());
            return false;
        }
    }
}
