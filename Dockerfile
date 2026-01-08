FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app
COPY . .
RUN dotnet publish -c Release src/Presentation/Nop.Web/Nop.Web.csproj -o published

# Runtime Stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /demo
COPY --from=build /app/published .
EXPOSE 5000
CMD ["dotnet", "Nop.Web.dll", "--urls=http://0.0.0.0:5000"]