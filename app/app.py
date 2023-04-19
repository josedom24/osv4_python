from flask import Flask, request,url_for,render_template,abort
from lxml import etree
import requests,os
app = Flask(__name__)	

@app.route('/',methods=["GET","POST"])
def inicio():
	prov=os.environ["PROVINCIA"]
	doc=etree.parse(prov+".xml")
	municipios=doc.findall("municipio")
	return render_template("inicio.html",municipios=municipios,prov=prov.title())

@app.route('/<code>')
def temperatura(code):
	prov=os.environ["PROVINCIA"]
	try:
		response = requests.get("http://www.aemet.es/xml/municipios/localidad_"+code+".xml")
		xml = response.content
		doc=etree.fromstring(xml)
	except:
		abort(404)
	name=doc.find("nombre").text
	max=doc.find("prediccion/dia/temperatura").find("maxima").text
	min=doc.find("prediccion/dia/temperatura").find("minima").text
	return render_template("temperaturas.html",name=name,max=max,min=min,prov=prov.title())

if __name__ == '__main__':
	app.run('0.0.0.0',8000,debug=True)
