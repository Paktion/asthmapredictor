
import boto3

s3 = boto3.resource('s3')
s3.meta.client.upload_file('model.joblib', 'sagemaker-studio-dpky3i1jbvs', 'model.joblib')