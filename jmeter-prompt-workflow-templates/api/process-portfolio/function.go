package portfolio

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
)

// PortfolioRequest represents the expected JSON input
type PortfolioRequest struct {
	Holdings []string `json:"holdings"`
}

// PortfolioResponse represents the JSON output
type PortfolioResponse struct {
	Size int `json:"size"`
}

// ProcessPortfolio handles the incoming HTTP request, counts the holdings, and returns the size.
func ProcessPortfolio(w http.ResponseWriter, r *http.Request) {
	// Set CORS headers to allow all origins
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

	var req PortfolioRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, fmt.Sprintf("Error parsing request: %v", err), http.StatusBadRequest)
		return
	}

	// Calculate the size of the holdings array
	size := len(req.Holdings)

	resp := PortfolioResponse{
		Size: size,
	}

	w.Header().Set("Content-Type", "application/json")
	if err := json.NewEncoder(w).Encode(resp); err != nil {
		log.Printf("Error encoding response: %v", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}
}
