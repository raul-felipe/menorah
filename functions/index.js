let functions = require('firebase-functions');

let admin = require('firebase-admin');

admin.initializeApp();

exports.sendNotification = functions.database.ref('/mensagem').onUpdate((snapshot, context)=> {

    if(snapshot.after.child('check').val()==true) {
        //get the message
        const conteudo = snapshot.after.child('conteudo').val();

        //get the title
        const titulo = snapshot.after.child('titulo').val();

        const topico = snapshot.after.child('usuario').val();

        const payload = {
            notification: {
                title: titulo,
                body: conteudo
            },
            topic: topico
        }
        console.log(payload);

        return admin.messaging().send(payload)
            .then((response) => {
                // Response is a message ID string.
                console.log('Successfully sent message:', response);
            })
            .catch((error) => {
                console.log('Error sending message:', error);
            });
    }
});