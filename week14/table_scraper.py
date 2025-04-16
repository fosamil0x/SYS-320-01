import requests
from bs4 import BeautifulSoup


url = 'http://10.0.17.6/Assignment.html'


response = requests.get(url)
response.raise_for_status()  # Raise HTTPError for bad responses (4xx or 5xx)
html = response.text


soup = BeautifulSoup(html, "html.parser")


# Locate the temperature table
temperature_table = soup.find('table', {'id': 'temp'})


# Locate the pressure table
pressure_table = soup.find('table', {'id': 'press'})


def extract_data(table, table_type):
    data = []
    rows = table.find_all('tr')[1:]  # Skip header row
    for row in rows:
        cols = row.find_all('td')
        if len(cols) == 2:
            value = cols[0].text.strip()  # Temperature or Pressure Value
            date_time = cols[1].text.strip()  # Date and Time
            data.append((value, date_time))
        else:
            data.append((None, None))  # Append None if the expected number of columns is not found
    return data


# Extract temperature data
temperature_data = []
if temperature_table:
    temperature_data = extract_data(temperature_table, 'temperature')


# Extract pressure data
pressure_data = []
if pressure_table:
    pressure_data = extract_data(pressure_table, 'pressure')


# Combine the data
combined_data = []
min_len = min(len(temperature_data), len(pressure_data))
for i in range(min_len):
    temp_value, temp_datetime = temperature_data[i]
    press_value, press_datetime = pressure_data[i]
    
    # Use the date from the temperature table, since they should match
    combined_data.append((temp_value, press_value, temp_datetime))


# Print the combined data
print("Temperature, Pressure, Date-Time")
for temp, press, date_time in combined_data:
    print(f"{temp}, {press}, {date_time}")