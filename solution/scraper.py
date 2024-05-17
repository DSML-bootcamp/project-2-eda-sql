import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin


def find_amazon_book_url(isbn):
    base_url = "https://www.amazon.de"
    search_url = f"{base_url}/s?k={isbn}"
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) \
            Gecko/20100101 Firefox/112.0"  # Simulate a browser
    }
    try:
        response = requests.get(search_url, headers=headers)
        response.raise_for_status()  # Check for HTTP errors
        soup = BeautifulSoup(response.content, "html.parser")
        book_result = soup.find("div", {"data-component-type": "s-search-result"})
        if book_result:
            book_link = book_result.find("a", class_="a-link-normal")["href"]
            return urljoin(base_url, book_link)
        else:
            return None
    except requests.exceptions.RequestException as e:
        print(f"Error during request: {e}")
        return None


if __name__ == "__main__":
    isbn = input("Enter ISBN: ")  # Get ISBN from user
    book_url = find_amazon_book_url(isbn)
    if book_url:
        print(f"Buy page URL: {book_url}")
    else:
        print("Book not found on Amazon.com.")
