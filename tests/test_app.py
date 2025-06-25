import os
import sys
import pytest

# Ensure project root is in sys.path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from app import app  # Now imports your local app.py, not global site-packages


@pytest.fixture
def client():
   """Flask test client setup."""
   app.config["TESTING"] = True
   with app.test_client() as client:
      yield client


def test_home_page(client):
   """Test homepage route returns 200 and contains basic HTML."""
   response = client.get("/")
   assert response.status_code == 200
   assert b"<html" in response.data.lower()
