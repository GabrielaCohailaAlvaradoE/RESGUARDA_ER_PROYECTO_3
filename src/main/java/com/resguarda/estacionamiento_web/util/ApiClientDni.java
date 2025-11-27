/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.util;

import com.google.gson.Gson;
import com.google.gson.annotations.SerializedName;
import com.resguarda.estacionamiento_web.modelo.TbUsuariosWeb; 
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import org.springframework.stereotype.Service; 

@Service // <-- 3. AÑADE ESTO
public class ApiClientDni {

    private static final String TOKEN = "sk_10666.6qrKjQbhjgKZpMH9rjMDfL6h6pOY84mt"; 

    public TbUsuariosWeb consultarDni(String dni) {
        
        TbUsuariosWeb clienteRespuesta = null;

        try {
            String url = "https://api.decolecta.com/v1/reniec/dni?numero=" + dni;

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Accept", "application/json")
                    .header("Authorization", "Bearer " + TOKEN)
                    .GET()
                    .build();

            HttpClient client = HttpClient.newHttpClient();
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() == 200) {
                Gson gson = new Gson();
                ApiResponseReniec apiResponse = gson.fromJson(response.body(), ApiResponseReniec.class);

                clienteRespuesta = new TbUsuariosWeb();
                clienteRespuesta.setNombres(apiResponse.getFirstName());
                clienteRespuesta.setApellidos(apiResponse.getFirstLastName() + " " + apiResponse.getSecondLastName());
                clienteRespuesta.setDni(apiResponse.getDocumentNumber());
            } else {
                System.err.println("La API externa devolvió un error: " + response.statusCode());
                System.err.println("Cuerpo del error: " + response.body());
                return null; // <-- Devuelve null si falla
            }

        } catch (Exception e) {
            e.printStackTrace();
            return null; // <-- Devuelve null si hay excepción
        }

        return clienteRespuesta;
    }
    
    // Clase interna (esto está perfecto como lo tenías)
    private static class ApiResponseReniec {
        @SerializedName("first_name")
        private String firstName;
        @SerializedName("first_last_name")
        private String firstLastName;
        @SerializedName("second_last_name")
        private String secondLastName;
        @SerializedName("document_number")
        private String documentNumber;

        public String getFirstName() { return firstName; }
        public String getFirstLastName() { return firstLastName; }
        public String getSecondLastName() { return secondLastName; }
        public String getDocumentNumber() { return documentNumber; }
    }
}