import pyrebase
firebaseConfig = {
    "apiKey": "AIzaSyCAThVaCCR-h0D5nTK5XeFWQfeUuY-wPMk",
    "authDomain": "krotic-web-server.firebaseapp.com",
    "databaseURL": "https://krotic-web-server.firebaseio.com",
    "projectId": "krotic-web-server",
    "storageBucket": "krotic-web-server.appspot.com",
    "messagingSenderId": "609691878481",
    "appId": "1:609691878481:web:b8fa441251a2c9fb71e470",
    "measurementId": "G-C14ZZHR3J0",
    "serviceAccount": "/home/pi/kroticAuth/krotic-web-server-firebase-adminsdk-fw7tm-2e7a5c0511.json"
}

firebase = pyrebase.initialize_app(firebaseConfig)
storage = firebase.storage()
# user = auth.sign_in_with_email_and_password("laboratoriolutec@gmail.com", "lablutec")

path_on_cloud1 = "mock_user/retroalimentacion/Cam0.avi"
path_on_cloud2 = "mock_user/retroalimentacion/Cam2.avi"
path_on_cloud3 = "mock_user/retroalimentacion/Cam4.avi"

path_local1 = "Grabaciones/Cam0.avi"
path_local2 = "Grabaciones/Cam2.avi"
path_local3 = "Grabaciones/Cam4.avi"

# storage.child(path_on_cloud1).put(path_local1)
# storage.child(path_on_cloud2).put(path_local2)
# storage.child(path_on_cloud3).put(path_local3)

vidLink1 = storage.child(path_on_cloud1).get_url(None)
vidLink2 = storage.child(path_on_cloud2).get_url(None)
vidLink3 = storage.child(path_on_cloud3).get_url(None)

print("ref video 1:")
print(vidLink1)
print("ref video 2:")
print(vidLink2)
print("ref video 3:")
print(vidLink3)

