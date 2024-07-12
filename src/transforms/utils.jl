# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

"""
    translation(T, transform)

Translation vector from parameters of `transform` with machine type `T`.
"""
function translation(::Type{T}, transform::Transform) where {T}
  δx = numconvert(T, transform.δx)
  δy = numconvert(T, transform.δy)
  δz = numconvert(T, transform.δz)
  SVector(δx, δy, δz)
end

"""
    rotation(T, transform)

`RotZYX` rotation from parameters of `transform` with machine type `T`.
"""
function rotation(::Type{T}, transform::Transform) where {T}
  θx = numconvert(T, transform.θx)
  θy = numconvert(T, transform.θy)
  θz = numconvert(T, transform.θz)
  RotXYZ(θx, θy, θz)
end

"""
    timedephelmert(Datumₛ, Datumₜ, δx=0.0, δy=0.0, δz=0.0, θx=0.0, θy=0.0, θz=0.0, s=0.0,
      dδx=0.0, dδy=0.0, dδz=0.0, dθx=0.0, dθy=0.0, dθz=0.0, ds=0.0)

Create a Helmert transform from time-dependent parameters:
epoch difference `dt = epoch(Datumₛ) - epoch(Datumₜ)`,
translation rates `dδx, dδy, dδz` in meters per year, 
rotation rates `dθx, dθy, dθz` in arc seconds per year 
and scale rate `ds` in ppm (parts per million) per year.

See also [`HelmertTransform`](@ref).

## References

* Section 4.3.5 of EPSG Guidance Note 7-2: <https://epsg.org/guidance-notes.html>
"""
function timedephelmert(
  ::Type{Datumₛ},
  ::Type{Datumₜ};
  δx=0.0,
  δy=0.0,
  δz=0.0,
  θx=0.0,
  θy=0.0,
  θz=0.0,
  s=0.0,
  dδx=0.0,
  dδy=0.0,
  dδz=0.0,
  dθx=0.0,
  dθy=0.0,
  dθz=0.0,
  ds=0.0
) where {Datumₜ,Datumₛ}
  dt = epoch(Datumₛ) - epoch(Datumₜ)
  HelmertTransform(
    δx=δx + dδx * dt,
    δy=δy + dδy * dt,
    δz=δz + dδz * dt,
    θx=θx + dθx * dt,
    θy=θy + dθy * dt,
    θz=θz + dθz * dt,
    s=s + ds * dt
  )
end
