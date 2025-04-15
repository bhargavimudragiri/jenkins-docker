# Use CentOS 8 Stream as the base image
FROM centos:8-stream

# Maintainer information
MAINTAINER vikashashoke@gmail.com

# Install EPEL release and necessary packages (httpd, zip, unzip)
RUN yum -y install epel-release && \
    yum -y install httpd zip unzip && \
    yum clean all

# Add the remote zip file to the container
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/

# Change working directory to /var/www/html
WORKDIR /var/www/html/

# Unzip the contents of the photogenic.zip file
RUN unzip photogenic.zip

# Copy the contents from the unzipped directory to the current directory
RUN cp -rvf photogenic/* .

# Remove the original photogenic folder and the zip file to clean up
RUN rm -rf photogenic photogenic.zip

# Expose port 80 for HTTP
EXPOSE 80

# Command to start Apache HTTPD in the foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
