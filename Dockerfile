# Etapa 1: Construção
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia os arquivos do projeto
COPY *.csproj ./
RUN dotnet restore

# Copia o restante do código fonte e faz o build
COPY . ./
RUN dotnet publish -c Release -o /app/publish

# Etapa 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copia os arquivos publicados da etapa de build
COPY --from=build /app/publish .

# Expõe a porta da aplicação
EXPOSE 8080

# Define o comando de execução da aplicação
ENTRYPOINT ["dotnet", "fiap-minimal-api.dll"]
