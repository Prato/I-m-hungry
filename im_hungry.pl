use strict;         # Enforce stricter coding practices.
use warnings;       # Warn about potential issues.
use URI;            # Handle URLs and query parameters.
use LWP::UserAgent; # Make HTTP requests.
use JSON;           # Parse and encode JSON data.

# Set URL for retrieving food truck permits.
my $endpoint_permits = "https://data.sfgov.org/resource/rqzj-sfat.json";
# Set URL for retrieving food truck schedules.
my $endpoint_schedule = "https://data.sfgov.org/resource/jjew-r69b.json";

# Make an object for making HTTP requests.
my $ua = LWP::UserAgent->new();

# UI: Prompt the user to enter the type of food they're looking for.
print "For what sort of food are you looking?: ";

# Store the input in the $food variable and converts it to uppercase for SoQL.
my $food = <>;
chomp($food);
$food = uc($food);
print "Very well, I shall find you $food!\n";

# Keep UserAgent from twice encoding the SoQL
local $URI::Escape::escapes{'%'} = '%';

# Create a URI object for the $endpoint_permits URL.
my $req = URI->new($endpoint_permits);

# Add query parameters:
# status: Filter for approved permits.
# $select: Select specific fields (permit and fooditems).
# $where: Filter for permits that include the specified food in their fooditems field.
$req->query_param( status => 'APPROVED');
$req->query_param( '$select' => 'permit,fooditems');
$req->query_param( '$where' => 'UPPER(fooditems)%20like%20"%25' . $food . '%25"' );

# Send the request using the $ua object.
my $res = $ua->get($req);

# Check if the request was successful.
# If successful, parse the JSON response and stores the permits in the @permits array.
# If unsuccessful, print an error message and exit.
my @permits;
if ($res->is_success) {
    print "Food Truck Fleet Contacted Successfully...\n";
    @permits = @{ decode_json($res->decoded_content) };
} else {
    die "Failed to fetch content from the URL: " . $res->status_line;
}

# If no permits are found, print a message indicating no suitable vendors.
if (scalar @permits == 0) {
    die "Unfortunately there were no suitable vendors and you will starve. :(";
}

# Initialize an empty hash to store information about each food truck.
my %trucks;

# Iterate through the @permits array.
foreach (@permits) {
    my $permit = $_->{permit};              # Extract the permit number.
    my $fooditems = $_->{fooditems};        # Extract the food items.
    my %truck =  (                          # Creates a hash
        'permit' => $permit,                #   with the permit number as the key
        'fooditems' => $fooditems,          #   and the extracted information as the value.
    );
    $trucks{$permit} = \%truck;              # Add this hash to the %trucks hash.
}

# Create a URI object for the $endpoint_schedule URL.
$req = URI->new($endpoint_schedule);

# Initialize an empty array to store further information about each truck.
my @schedule;

# Iterate through the keys of the %trucks hash (permit numbers).
foreach my $key (keys %trucks) {
    $req->query_param( permit => $key );    # Filter for the current permit.
    $req->query_param( '$select' => 'permit,applicant,start24,end24,location'); # Select specific fields.
    $req->query_param( '$limit' => '1');    # Limit to one result (workaround for non-unique permits).
    $res = $ua->get($req);                  # Send the request.

    # Parse the JSON from the response and store it in the array.
    push(@schedule, @{ decode_json($res->decoded_content) });

    # Iterate over the particular scheduling information and store it for each truck.
    foreach (@schedule) {
        $trucks{$key}->{applicant} = $_->{applicant};
        $trucks{$key}->{location} = $_->{location};
        $trucks{$key}->{start24} = $_->{start24};
        $trucks{$key}->{end24} = $_->{end24};
    }
}

# UI: Respond to user with 
print "\n******** As requested, you may acquire $food at the following locations:\n\n";

# Iterate through the %trucks hash and lightly format the data for the perspective diner.
# If blank fields are encountered, the blank string abides. 
foreach my $key (keys %trucks) {
    print "**" . ($trucks{$key}->{applicant} // '') . "**\n";
    print "* Location: " . ($trucks{$key}->{location} // '') . "\n";
    print "* Serving: " . ($trucks{$key}->{fooditems} // '') . "\n";
    print "* Hours: " . ($trucks{$key}->{start24} // '') . " - " . ($trucks{$key}->{end24} // '') . "\n\n";
}

1;