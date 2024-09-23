# Usa una imagen base de .NET SDK 8.0 para compilar la aplicación
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia el archivo de proyecto y restaura las dependencias
COPY ["BlazingPizza.csproj", "./"]  
RUN dotnet restore

# Copia el resto del código de la aplicación y compila
COPY . .
RUN dotnet publish "BlazingPizza.csproj" -c Release -o /app/publish  # Especifica el archivo .csproj

# Usa una imagen base de .NET ASP.NET Core Runtime 8.0 para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copia los archivos compilados desde la etapa de construcción
COPY --from=build /app/publish .

# Exponer el puerto 5000
EXPOSE 5000

# Comando para ejecutar la aplicación
ENTRYPOINT ["dotnet", "BlazingPizza.dll"]
