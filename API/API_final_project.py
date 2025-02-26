from flask import Flask, jsonify, request
import pymysql

#Initialize Flask app
app = Flask(__name__)


def get_data_base_connection():
    try:
        connection = pymysql.connect(user = "root",
                                        password= "Libelula11!",
                                        database= "final_project",
                                        cursorclass= pymysql.cursors.DictCursor) #Saying that data will
        return connection                   #get shown as a dictionary to the user
      
    except Exception as e:
        print(f'Error Connecting to database: {e}')
        return None

get_data_base_connection()

#Defining first route:

@app.route("/final_project", methods = ["GET"])
def get_final_project():
    conn = get_data_base_connection()
    if not conn: # if I don't have connection defined
        return jsonify ({"error":"Failed to connect to database"}), 500
    
    with conn.cursor() as cursor:
        query= """SELECT customerEmail, transactionAmount FROM final_project;"""
        cursor.execute(query)
        final_project= cursor.fetchall()

    conn.close() #Closing connection

    return jsonify (final_project)



if __name__ == "__main__":
    app.run(debug=True)