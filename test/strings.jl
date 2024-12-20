@testset "CRS strings" begin
  crsstringtest(EPSG{2157})
  crsstringtest(EPSG{3395})
  crsstringtest(EPSG{3857})
  crsstringtest(EPSG{4269})
  crsstringtest(EPSG{4326})
  crsstringtest(EPSG{4618})
  crsstringtest(EPSG{4674})
  crsstringtest(EPSG{4686})
  crsstringtest(EPSG{5527})
  crsstringtest(EPSG{32662})
  crsstringtest(EPSG{32633})
  crsstringtest(EPSG{25832})
  crsstringtest(EPSG{27700})
  crsstringtest(EPSG{29903})
  crsstringtest(ESRI{54017})
  crsstringtest(ESRI{54030})
  crsstringtest(ESRI{54034})
  crsstringtest(ESRI{54042})
  crsstringtest(ESRI{102035})
  crsstringtest(ESRI{102037})

  # parsing errors
  # CRS format not supported
  str = "PROJ(NAME=Mercator, DATUM=WGS84)"
  @test_throws ArgumentError CoordRefSystems.string2code(str)
  # invalid WKT string
  str = """
  GEOG["GCS_WGS_1984",
    DATUM["D_WGS_1984",
        SPHEROID["WGS_1984",6378137.0,298.257223563]],
    PRIMEM["Greenwich",0.0],
    UNIT["Degree",0.0174532925199433]]"""
  @test_throws ArgumentError CoordRefSystems.string2code(str)
  # CRS ID not found in the WKT2 string
  str = "PROJCRS[]"
  @test_throws ArgumentError CoordRefSystems.string2code(str)
  # datum not found in the WKT1 string
  str = """
  GEOGCS["GCS_WGS_1984",
    PRIMEM["Greenwich",0.0],
    UNIT["Degree",0.0174532925199433]]
  """
  @test_throws ArgumentError CoordRefSystems.string2code(str)
  # ESRI ID of the CRS not found in the ESRI WKT string
  str = """
  GEOGCS[
    DATUM["D_WGS_1984",
        SPHEROID["WGS_1984",6378137.0,298.257223563]],
    PRIMEM["Greenwich",0.0],
    UNIT["Degree",0.0174532925199433]]
  """
  @test_throws ArgumentError CoordRefSystems.string2code(str)
  # CRS for the ESRI ID "test" not found in dictionary
  str = """
  GEOGCS["test",
    DATUM["D_WGS_1984",
        SPHEROID["WGS_1984",6378137.0,298.257223563]],
    PRIMEM["Greenwich",0.0],
    UNIT["Degree",0.0174532925199433]]
  """
  @test_throws ArgumentError CoordRefSystems.string2code(str)
  # CRS AUTHORITY not found in the WKT1 string
  str = """
  GEOGCS["WGS 84",
    DATUM["WGS_1984",
        SPHEROID["WGS 84",6378137,298.257223563,
            AUTHORITY["EPSG","7030"]],
        AUTHORITY["EPSG","6326"]],
    PRIMEM["Greenwich",0,
        AUTHORITY["EPSG","8901"]],
    UNIT["degree",0.0174532925199433,
        AUTHORITY["EPSG","9122"]],
    AXIS["Latitude",NORTH],
    AXIS["Longitude",EAST]]
  """
  @test_throws ArgumentError CoordRefSystems.string2code(str)
end
