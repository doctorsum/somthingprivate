FROM ubuntu:latest

RUN apt-get update && apt-get install -y wget python3 python3-pip

RUN mkdir -p /app

WORKDIR /app

RUN wget -c -t 0 --no-check-certificate --limit-rate=0 -O /app/XFCE_64bit.7z "https://sourceforge.net/projects/osboxes/files/v/vb/4-Ar---c-x/20240601/XFCE/64bit.7z/download"

RUN pip3 install Flask --break-system-packages

COPY <<EOF /app/app.py
from flask import Flask, send_file

app = Flask(__name__)

@app.route('/')
def index():
    return '''
    <h1>This Page is Under Developing..</h1>
    '''

@app.route('/file')
def download_file():
    return send_file("XFCE_64bit.7z", as_attachment=True)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=7860)
EOF

EXPOSE 7860

CMD ["python3", "app.py"]
