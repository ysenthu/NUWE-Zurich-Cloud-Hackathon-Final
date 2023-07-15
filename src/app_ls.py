# Localstack app version
# This is a python skeleton, you can modify this as you need

from flask import Flask, redirect, render_template, request
import boto3
import os

app = Flask(__name__)

# S3 bucket name
Bucket_Name = os.getenv("S3_BUCKET_NAME")

# AWS Creds

# S3 Client
s3_client = boto3.client('s3' )

# Index route
@app.route('/')
def index():
    return render_template('index.html')

# Upload route
@app.route('/upload', methods=['POST'])
def upload():
    if 'image' not in request.files:
        return 'No image selected', 400
    
    image = request.files['image']

    # Store image in S3 bucket
    s3_client.upload_fileobj(image, Bucket_Name, image.filename)

    return 'Image upload successfully'

@app.route('/supersecret')
def secret():
    video_url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'  
    return redirect(video_url)

if __name__ == '__main__':
    app.run()
