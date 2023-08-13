#!/usr/bin/python3

from datetime import datetime, timedelta
import sys
import time
REFRESH_INTERVAL = 10


def repr_delta(delta: timedelta):
    # repr = []
    days = delta.days
    hours = delta.seconds // 3600
    seconds = delta.seconds - hours * 3600
    mins = seconds // 60
    seconds = seconds - mins * 60
    return f"{days}d:{hours}h:{mins}m:{seconds}s"


if __name__ == "__main__":
    args = sys.argv[1:]
    assert len(args) >= 2
    topic = args[0]
    deadline = args[1]
    interval = 1
    if len(args) > 2:
        interval = int(args[2])
    date_obj = datetime.strptime(deadline, "%d/%m/%y-%H:%M:%S")
    delta = date_obj - datetime.now()
    count = 0
    while True:
        print(topic, repr_delta(delta), flush=True)
        time.sleep(interval)
        delta -= timedelta(seconds=interval)
        count += 1
        if count > REFRESH_INTERVAL:
            count = 0
            delta = date_obj - datetime.now()
            count = 0
