from flask import Flask, render_template, abort, redirect, request
import datetime
import socket
import os

app = Flask(__name__)	

@app.route('/',methods=["GET","POST"])
def inicio():
    hoy=datetime.datetime.now()
    info=os.environ["INFORMACION"]
    return render_template("inicio.html",hoy=hoy,server=socket.gethostname(),info=info)



app.run('0.0.0.0',8000,debug=True)