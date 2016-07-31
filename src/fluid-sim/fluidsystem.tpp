template<std::size_t numCoords>
void FluidSystem::advect(VectorField<numCoords> &out, const VectorField<numCoords> &in,
                         const VelocityField &velocity, Scalar dt,
                         std::array<BoundarySetter, numCoords> boundarySetters) const {
    for (std::size_t d = 0; d < numCoords; ++d) {
      for (Grid::Index i = 1; i <= gridSize; ++i) {
        for (Grid::Index j = 1; j <= gridSize; ++j) {
          Scalar x = i - dt * gridSize * velocity[0](i, j);
          Scalar y = j - dt * gridSize * velocity[1](i, j);
          x = std::max(0.5f, std::min(gridSize + 0.5f, x));
          y = std::max(0.5f, std::min(gridSize + 0.5f, y));
          out[d](i, j) = interpolate(in[d], x, y);
        }
      }
      boundarySetters[d](out[d]);
    }
}

template<std::size_t numCoords>
void FluidSystem::diffuse(VectorField<numCoords> &out, const VectorField<numCoords> &in,
                          Scalar diff, Scalar dt,
                          std::array<BoundarySetter, numCoords> boundarySetters) const {
    Scalar a = dt * diff * gridSize * gridSize;
    for (std::size_t d = 0; d < numCoords; ++d) {
      solvePoisson(out[d], in[d], a, 1 + 4 * a, boundarySetters[d]);
    }
}