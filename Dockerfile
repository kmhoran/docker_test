FROM mcr.microsoft.com/dotnet/core/sdk:2.2 as build-env
WORKDIR /app/
# copy files to current directory
COPY . ./
RUN dotnet restore

# Copy everything else and build
RUN dotnet publish DockerWeb/DockerWeb.csproj -c Release -o /app/out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /app/
COPY --from=build-env /app/out ./
EXPOSE 5000
ENTRYPOINT ["dotnet", "DockerWeb.dll"]