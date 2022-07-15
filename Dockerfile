# Buil Stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source
COPY . .
RUN dotnet restore "./SimpleMinimalApi/SimpleMinimalApi.csproj" --disable-parallel
RUN dotnet publish "./SimpleMinimalApi/SimpleMinimalApi.csproj" -c release -o /app --no-restore
# Serve Stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app ./

EXPOSE 7055

ENTRYPOINT ["dotnet", "SimpleMinimalApi.dll"]