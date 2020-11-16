from datetime import datetime
from flask import Flask, request, jsonify
from flask.logging import create_logger

import logging
import random
import uuid

app = Flask(__name__)
LOG = create_logger(app)
LOG.setLevel(logging.INFO)


@app.route("/")
def home():
    LOG.info("Get call on /")
    user_number = random.randint(1, 101)
    return jsonify(
        id=uuid.uuid1(),
        username="The user " + str(user_number),
        email="lorem.ipsum+" + str(user_number) + "@email.com",
        date=datetime.now(),
        telephone="+999 " + str(random.randint(101, 800)) +
        " " + str(random.randint(101, 800)) + " " +
        str(random.randint(101, 800)),
        x_request_id=uuid.uuid1(),
        biography="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac leo " +  
        "vehicula, tempus felis quis, sollicitudin felis. Donec vel erat mauris. Nulla facilisi. " + 
        "Aenean ac est eget ipsum pretium convallis quis vulputate nisl. Integer viverra neque quis " + 
        "elit pellentesque, viverra congue leo porta. Praesent elit justo, tempor sit amet varius ac," +
        "feugiat sed nibh. Nam sit amet semper nisi, vitae hendrerit erat. Orci varius natoque penatibus " +
        "et magnis dis parturient montes, nascetur ridiculus mus. Duis ultricies lorem libero, vel " +
        "condimentum neque aliquam vel. Integer non odio nisi. Sed nec orci purus.",
        version="0.0.5"
    )


@app.route("/healthcheck")
def healthcheck():
    return "healthy\n"


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True) # specify port=5000
