package main

import "time"

var start = time.Now()

func nanotime() int64 { return int64(time.Since(start)) }
