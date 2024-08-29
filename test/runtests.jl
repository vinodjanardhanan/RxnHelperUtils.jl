using RxnHelperUtils
using Test

@testset "RxnHelperUtils.jl" begin

    csv_stream = open("stest.csv", "w")
    data = ["ch4", "co2", "o2"]
    write_csv(csv_stream, data)
    close(csv_stream)
    
    csv_stream = open("rtest.csv", "w")
    data = [0.123e-5, 1.2354, 3.14]
    write_csv(csv_stream, data)
    close(csv_stream)

    csv_stream = open("srtest.csv", "w")
    data = ["ch4", 0.123e-5, 1.2354, 3.14]
    write_csv(csv_stream, data)
    close(csv_stream)

    csv_stream = open("args.csv", "w")
    write_csv(csv_stream, data, "ch2oh", 1.3, 0.12e-6, ["cho", 0.312])
    close(csv_stream)

    retcode = convert2si("cm")
    @test retcode == 0.01

    retcode = get_index("CH4",["CH4", "CO2"])
    @test retcode == 1
end
