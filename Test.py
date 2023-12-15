from flask import Flask, request, jsonify
from pyswip import Prolog

app = Flask(__name__)
prolog = Prolog()
prolog.consult("test.pl")  # Load your Prolog file

@app.route('/getRecommendation', methods=['POST'])
def get_recommendation():
    data = request.json
    result = get_workout_recommendation(
        data['goal'], 
        data['level'], 
        data['health'], 
        data['equipment'], 
        data['time']
    )
    return jsonify(result)

def get_workout_recommendation(goal, level, health, equipment, time):
    query = f"recommend_workout({goal}, {level}, {health}, {equipment}, {time}, Workout)"
    result = list(prolog.query(query))
    return result

if __name__ == "__main__":
    app.run(debug=True)
