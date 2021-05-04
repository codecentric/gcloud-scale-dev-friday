import json, uuid, random

DOMAINS = [
    "codecentric.de",
    "codecentric.com",
    "devdriday.net",
    "example.com",
    "onlineshoppingmania.de",
]

SERVICES = [
    "essential-1",
    "essential-2",
    "essential-3",
    "essential-4",
    "essential-5",
    "web_performance_and_analytics-1",
    "web_performance_and_analytics-2",
    "web_performance_and_analytics-3",
    "web_performance_and_analytics-4",
    "web_performance_and_analytics-5",
    "functional-1",
    "functional-2",
    "functional-3",
    "functional-4",
    "functional-5",
    "personalization-1",
    "personalization-2",
    "personalization-3",
    "personalization-4",
    "personalization-5",
    "marketing-1",
    "marketing-2",
    "marketing-3",
    "marketing-4",
    "marketing-5",
]


if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Generate messages.")
    parser.add_argument("--num_messages", type=int, help="Number of messages to generate", default=2_000_000)
    parser.add_argument("--seed", type=int, help="Random seed for reproducability", default=0)
    parser.add_argument("--out_file", type=str, help="File to write the messages", default="output.txt")

    args = parser.parse_args()

    random.seed(args.seed)

    n_services = len(SERVICES)

    with open(args.out_file, "w") as f:
        for i in range(args.num_messages):
            user = str(uuid.uuid4())
            domain = random.choice(DOMAINS)
            services = random.sample(SERVICES, random.randrange(n_services))

            message = {"user": user, "domain": domain, "services": services}
            f.write(json.dumps(message) + "\n")
