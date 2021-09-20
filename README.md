# Smooth Loop
A library which helps you to loop your tables in a defined time.

## About
This library will help you to loop tables in a defined time. Let's say you want to loop a table and it must take 30 seconds to finish. Well, this library does that. For instance, it will only process tables which have numbers as index. (**ipairs** table)

## Parameters
```lua
SmoothLoop.new(table, msToFinish, callback):run()
```

### table
Your table to process.

### msToFinish
Time, in milliseconds, for the loop to finish.

### callback
Your callback function, which will give in the parameters, the value and the index, respectively.

## Run
To run the loop, you **must** add the `run` method in the final of the call of the function. Of course, you could store it in a variable and use it later. Example:
```lua
local myStuff = SmoothLoop.new(table, msToFinish, callback)
```
So, in another moment, you would use:
```lua
myStuff:run()
```

## Using examples (from MTA:SA)
```lua
SmoothLoop.new(getElementsByType("vehicle"), 5000, function(v, i)
    if v and isElement(v) then
        local r, g, b = math.random(255), math.random(255), math.random(255)
        setVehicleColor(v, r, g, b)
        iprint("Alterando a cor do veículo " .. getVehicleName(v))
    end
end):run()
```
This example will change the vehicles color. The loop will take 5 seconds (5000 ms) to finish. So, doing some math, let's say we have 50 vehicles on the server. The math would be:
`5000 / 50`, which results in `100`. The result will be, internally, the interval time of the `setTimer` function, that is, **100ms** for each vehicle.

## Author
[androksi](https://forum.mtasa.com/profile/50045-androksi/)
