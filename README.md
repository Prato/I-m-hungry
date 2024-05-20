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
cd I-m-hungry
cpanm URI LWP::UserAgent JSON
```

3. **Run the script:**

```bash
perl im_hungry.pl
```

4. **Enter the type of food you're looking for:**

The script will prompt you to enter the type of food you're interested in. For example, you could enter "tacos", "pizza", or "vegetarian".

5. **View the results:**

The script will print a list of food trucks that serve the specified food, along with their location, food items, and hours of operation.

## Example Usage

```
For what sort of food are you looking?
tacos
Very well, I shall find you TACOS!

Food Truck Fleet Contacted Successfully...

As requested, you may acquire TACOS at the following locations:

**El Tonayense**
* Location: 24th St & Mission St
* Serving: Tacos, burritos, quesadillas
* Hours: 11:00 - 21:00

**La Taqueria**
* Location: 29th St & Mission St
* Serving: Tacos, burritos, quesadillas
* Hours: 10:00 - 21:00

**Taqueria Cancun**
* Location: 16th St & Mission St
* Serving: Tacos, burritos, quesadillas
* Hours: 11:00 - 19:00
