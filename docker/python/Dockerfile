# From means we are going to use the official node in the docker repository
# Pulling the base image
FROM python:alpine3.12

# Create group, user, to have all permissions
RUN addgroup appGroup && adduser -S -G appGroup appUser
USER appUser

#Defining directory
WORKDIR pythonapp
COPY . .

# installing request dependencies
RUN python -m pip install requests
# Execute command
CMD ["python", "app.py"]
#CMD python app.py
