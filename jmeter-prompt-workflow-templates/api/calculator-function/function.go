package calculator

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
)

// CalculateRequest represents the expected JSON input
type CalculateRequest struct {
	Number1 float64 `json:"num1"`
	Number2 float64 `json:"num2"`
}

// CalculateResponse represents the JSON output
type CalculateResponse struct {
	Result float64 `json:"result"`
}


// Calculate handles the incoming HTTP request, parses the two numbers, and returns the sum.
func Calculate(w http.ResponseWriter, r *http.Request) {
	// Set CORS headers to allow all origins (for demo/testing purposes)
	w.Header().Set("Access-Control-Allow-Origin", "*")
	if r.Method == http.MethodOptions {
		w.Header().Set("Access-Control-Allow-Methods", "POST")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type")
		w.Header().Set("Access-Control-Max-Age", "3600")
		w.WriteHeader(http.StatusNoContent)
		return
	}

	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	var req CalculateRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, fmt.Sprintf("Error parsing request: %v", err), http.StatusBadRequest)
		return
	}

	// Calculate the sum
	sum := req.Number1 + req.Number2

	resp := CalculateResponse{
		Result: sum,
	}

	w.Header().Set("Content-Type", "application/json")
	if err := json.NewEncoder(w).Encode(resp); err != nil {
		log.Printf("Error encoding response: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}
}
