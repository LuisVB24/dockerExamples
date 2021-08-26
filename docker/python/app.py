import requests, json, datetime
from json.encoder import py_encode_basestring
from requests.api import get

class json_info:
    def __init__(self, link):
        self.link = link
        self.url = requests.get(link)
        self.data = json.loads(self.url.text)

# Method for answered and unanswered answers
# items and answers paths defined, but specifiable if necessary
    def answered_and_not(self, items='items', answers='is_answered'):
        data = self.data
        true = false = 0
        for x in range (len(data[items])):
            try:
                if data[items][x][answers] == True:
                    true += 1
                else:
                    false += 1
            except:
                pass
        return true,false

# Method for more reputation response
# items and own and reputation paths defined, but specifiable if necessary
    def max_petutation(self,items='items', own='owner', rep= 'reputation'):
        reputation = 0
        data = self.data
        for x in range(len(data[items])):
            try:
                if reputation < data[items][x][own][rep]:
                    position = x
                    reputation = data[items][x][own][rep]
            except:
                pass
        return reputation,position

# Method for fewer views
# items and answers paths defined, but specifiable if necessary
    def min_view_count(self, items='items', views='view_count'):
        data = self.data
        min_count = data[items][0][views]
        for x in range(len(data[items])):
            try:
                if min_count >= data[items][x][views]:
                    position = x
                    min_count = data[items][x][views]
            except:
                pass
        return min_count, position

# Method for Recent and Older Creation date
# items and date paths defined, but specifiable if necessary
    def recent_and_older(self, items='items', cDate='creation_date'):
        data = self.data
        recent = data[items][0][cDate]
        older = data[items][0][cDate]
        for x in range(len(data[items])):
            try:
                if recent < data[items][x][cDate]:
                    recent = data[items][x][cDate]
                if older > data[items][x][cDate]:
                    older = data[items][x][cDate]
            except:
                pass
        date_recent = datetime.datetime.fromtimestamp(recent).strftime('%Y-%m-%d %H:%M:%S')
        date_older = datetime.datetime.fromtimestamp(older).strftime('%Y-%m-%d %H:%M:%S')
        return date_recent, date_older


link = 'https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=perl&site=stackoverflow'
xalTest = json_info(link)

print('\n---------------------- Numero de Respuestas ----------------------')
print('\tContestadas: ' + str(xalTest.answered_and_not()[0]), end =' ')
print('\tNO Contestadas: ' + str(xalTest.answered_and_not()[1]))

print('\n------------------ Respuesta con más Reputacion ------------------')
print('Reputacion: ' + str(xalTest.max_petutation()[0]), end=' ')
print('  que pertenece a la poscicion: ' + str(xalTest.max_petutation()[1]))

print('\n------------------- Respuesta con Menos Vistas -------------------')
print('EL menor numero de vistas es: ' + str(xalTest.min_view_count()[0]), end=' ')
print(' que pertenece a la poscicion: ' + str(xalTest.min_view_count()[1]))

print('\n--------------- Respuesta mas Antigua y mas Actual ---------------')
print('La respuesta mas antigua es:   ' + str(xalTest.recent_and_older()[1]))
print('La respuesta mas reciente es:  ' + str(xalTest.recent_and_older()[0]))
print(' ')