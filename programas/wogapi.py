#!/usr/bin/python3
from flask import Flask, jsonify, request, Response
import http.client
import logging
from logging.config import dictConfig
import random
import sys

app = Flask(__name__)




# VARIABLES --------------------------

DamageList = [
	'0', 
	'0 + Red Jam', 
	'0 - Green Jam', 
	'1', 
	'1 + Rudder right', 
	'1 + Rudder left', 
	'2 + Rudder right', 
	'2 + Rudder left', 
	'2 + Red Jam', 
	'2 + Green Jam', 
	'2 + Fire', 
	'3', 
	'3 + Engine', 
	'3 + Pilot', 
	'4', 
	'4 + smoke',  
	'5', 
	'Fuell - 3', 
	'boom' 
]

CampaingList = [
	'1. PATRULLA EN EL ALBOR DE LA GUERRA:   Dos patrullas se atacan mutuamente en el frente. | Mapa:90x90cm | Aviones: Similares caracteristicas | 2 a 4 jugadores ', 
	'2. CARA A CARA: Dos cazas aislados, que patrullan sobre el frente, se encuentran e inician un duelo. | 80x80cm | Aviones: Similares o a eleccion | 2 a 6 ', 
	'3. HECHA UN VISTAZO: Un avion de reconocimiento es enviado para fotografiar posibles objetivos | 120x90cm | Objetivos: Cartas de objetivos a eleccion. | 1 a 6',
	'4. MUERTE DESDE EL CIELO: Una patrulla es enviada a atacar unas tropas terrestres. | 120x90 | Objetivos: Cartas de objetivos a eleccion. | 1 a 4',
	'5. UNA PESADA CARGA: Unos aviones intentan bombardear posiciones enemigas. | 120x90 | Objetivos: Colocar carta objetivo de cada jugador y bombardear el del enemigo | 2 a 8',
	'6. CONTRA LA CABEZA DE PUENTE: Una patrulla de reconocimiento debe verificar las supuestas posiciones de depositos aliados en la costa, para preparar un ataque contra ellos. | 120x120 | 2 a 6',
	'7. SOBREVOLANDO LA BATALLA: Aviones de ambos bandos participan en un combate entre tropas terrestres. | 120x90 | Objetivos: Eliminar carta objetivo del enemigo (carta objetivo terrestre a eleccion) | 2 a 4',
	'8. ACABA CON ESAS TROPAS: Dos aviones atacan posiciones de tierra desprovistas de defenza aerea | 90x90 | Objetivos:  .... | 1 a 2',
	'9. BOMBARDEO: ...'
]


# ROUTES-----------------------------------------------------------------------------------------------------
@app.route('/info', methods=['GET'])
def get_help():
    return "Wings of Glory API\n /damage to get random dice (damage) \n /campaing to get random Campaing "


#-----------------------------------------------------------------------
@app.route('/damage', methods=['GET'])
def get_damage():
    #print(random.choice(DamageList))
    response = "<h1>Damage: "+random.choice(DamageList)+"</h1>"
    return response


#-----------------------------------------------------------------------
@app.route('/campaing', methods=['GET'])
def get_campaing():
    #print(random.choice(CampaingList))
    response = "<h1>Campaing: "+random.choice(CampaingList)+"</h1>"
    return response

#---LOGS --------------------------------------------------------------------------------------------------------
dictConfig({
    'version': 1,
    'formatters': {'default': {
        'format': '[%(asctime)s] %(levelname)s in %(module)s: %(message)s',
    }},
    'handlers': {'wsgi': {
        'class': 'logging.StreamHandler',
        'stream': 'ext://sys.stdout',
        'formatter': 'default'
    }},
    'root': {
        'level': 'INFO',
        'handlers': ['wsgi']
    }
})

# OPTIONAL LOG TO FILE
#logging.basicConfig(level=logging.INFO,
#                    format='%(asctime)s %(levelname)-8s %(message)s',
#                    datefmt='%a, %d %b %Y %H:%M:%S',
#                    filename='/tmp/datadogapi.log',
#                    filemode='w')

#-----------------------------------------------------------------------------------------------------------


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80, debug=False) # Open a webserver on port 8088
    handler = logging.StreamHandler(sys.stdout)
    app.logger.addHandler(handler)
