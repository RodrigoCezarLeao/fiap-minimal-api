# Etapa 1: Constru��o
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia os arquivos do projeto
COPY *.csproj ./
RUN dotnet restore

# Copia o restante do c�digo fonte e faz o build
COPY . ./
RUN dotnet publish -c Release -o /app/publish

# Etapa 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copia os arquivos publicados da etapa de build
COPY --from=build /app/publish .

# Exp�e a porta da aplica��o
EXPOSE 8080

# Define o comando de execu��o da aplica��o
ENTRYPOINT ["dotnet", "fiap-minimal-api.dll"]
