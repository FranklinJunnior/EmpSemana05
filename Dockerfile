# Usa una imagen base de .NET
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 5000

# Usa una imagen base de .NET SDK para compilar la aplicación
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY BlazingPizza.csproj .
RUN dotnet restore "BlazingPizza.csproj"
COPY . .
WORKDIR "/src"
RUN dotnet build "BlazingPizza.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "BlazingPizza.csproj" -c Release -o /app/publish

# Configura la imagen final
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BlazingPizza.dll"]
