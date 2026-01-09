FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY . .
RUN dotnet publish src/Presentation/Nop.Web/Nop.Web.csproj -c Release -o published

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /demo
COPY --from=build /app/published .
EXPOSE 5000
CMD ["dotnet", "Nop.Web.dll", "--urls=http://0.0.0.0:5000"]
