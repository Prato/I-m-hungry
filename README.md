# I-m-hungry
coding challenge

This Perl script helps you find food trucks in San Francisco that serve a specific type of food.
*The visualization is already available on [DataSF](https://data.sfgov.org/Economy-and-Community/Mobile-Food-Permit-Map/px6q-wjh5).*

## How to Use

1. **Clone the repository:**

```bash
git clone https://github.com/prato/I-m-hungry.git
```

2. **Install dependencies:**

```bash
cd food-truck-finder
cpanm URI LWP::UserAgent JSON
```

3. **Run the script:**

```bash
perl food_truck_finder.pl
```

4. **Enter the type of food you're looking for:**

The script will prompt you to enter the type of food you're interested in. For example, you could enter "tacos", "pizza", or "vegetarian".

5. **View the results:**

The script will print a list of food trucks that serve the specified food, along with their location, food items, and hours of operation.

## Example Usage

```
Enter the type of food you're looking for: tacos

## Tacos

**El Tonayense**
* Location: 24th St & Mission St
* Food items: Tacos, burritos, quesadillas
* Hours of operation: Mon-Fri 11am-8pm, Sat-Sun 10am-7pm

**La Taqueria**
* Location: 29th St & Mission St
* Food items: Tacos, burritos, quesadillas
* Hours of operation: Mon-Fri 10am-9pm, Sat-Sun 9am-8pm

**Taqueria Cancun**
* Location: 16th St & Mission St
* Food items: Tacos, burritos, quesadillas
* Hours of operation: Mon-Fri 11am-7pm, Sat-Sun 10am-6pm
