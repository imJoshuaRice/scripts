# Windows has a 'USER Object' limit of 10,000. Hitting this limit causes an application to crash.
# This script was originally used to determine if this was the cause of an application related crash that would occur after 4-5 hours of use.

import matplotlib.pyplot as plt
from datetime import datetime

# Initialize lists to store the dates and object counts
dates = []
object_counts = []

# Read the log file
with open('logfile.txt', 'r') as file:
  for line in file:
    # Extract the date and object count from each line
    parts = line.split(' - ')
    date_str = parts[0]
    count_str = parts[1].split(': ')[1]

    # Convert the date string to a datetime object
    date = datetime.strptime(date_str, '%Y-%m-%d %H:%M:%S')

    # Append the date and object count to the respective lists
    dates.append(date)
    object_counts.append(int(count_str))

# Plot the data
plt.plot(dates, object_counts)
plt.xlabel('Date')
plt.ylabel('Number of USER Objects')
plt.title('Changes in Number of USER Objects over Time')
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()
