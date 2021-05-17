FROM mydocker/aspnetcore:apline5.0.6 

ENV DOTNET_DLL=ttt.dll DOTNET_ARG=

RUN mkdir -p /etc/services.d/app1 && \
echo IyEvdXNyL2Jpbi93aXRoLWNvbnRlbnYgYmFzaApjZCAvYXBwIHx8IGV4aXQKCmV4ZWMgXAoJczYtc2V0dWlkZ2lkIHJveCBkb3RuZXQgYXJnMSBhcmcy | base64 -d >/etc/services.d/app1/run && \
sed -i 's/arg1/'"${DOTNET_DLL}"'/g' /etc/services.d/app1/run && \
sed -i 's/arg2/'"${DOTNET_ARG}"'/g' /etc/services.d/app1/run

COPY publish/ /app/

EXPOSE 5000 
