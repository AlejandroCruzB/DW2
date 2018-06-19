from handlers.base import BaseHandler
from google.appengine.api import mail


class EmailNewCommentWorker(BaseHandler):
    def post(self):
        topic_author_email = self.request.get("topic_author_email")
        topic_title = self.request.get("topic_title")
        topicid = self.request.get("topicid")

        mail.send_mail(sender="alejandro90561@gmail.com",
                       to=topic_author_email,
                       subject="Nuevo comentario en tu topic",
                       body="""Tu topic {} ha recibido un nuevo comentario.
                              Haz click en http://my-ninja-tech-forum.appspot.com/topic/{} para poder verlo.""".format(
                           topic_title,
                           topicid
                           )
                       )