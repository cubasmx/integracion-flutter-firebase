import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pokemon_provider.dart';
import '../models/pokemon.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _offset = 0;
  final int _limit = 20;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PokemonProvider>().getPokemons(limit: _limit, offset: _offset);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchPokemon() {
    final name = _searchController.text.trim();
    if (name.isNotEmpty) {
      context.read<PokemonProvider>().getPokemon(name);
    }
  }

  void _loadMorePokemons() {
    _offset += _limit;
    context.read<PokemonProvider>().getPokemons(limit: _limit, offset: _offset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.red.shade900,
                Colors.red.shade800,
                Colors.red.shade700,
              ],
            ),
          ),
          child: Column(
            children: [
              // Header Pokédex
              _buildPokedexHeader(),
              // Cuerpo principal
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.red.shade700, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Pantalla principal
                      Expanded(
                        flex: 3,
                        child: _buildMainScreen(),
                      ),
                      // Divider
                      Container(
                        height: 4,
                        color: Colors.red.shade700,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      // Pantalla secundaria (lista)
                      Expanded(
                        flex: 2,
                        child: _buildSecondaryScreen(),
                      ),
                      // Controles
                      _buildControls(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPokedexHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.red.shade300,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.red.shade300.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'POKÉDEX',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 4,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade300.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainScreen() {
    return Consumer<PokemonProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading && provider.pokemon == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'CARGANDO...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }

        if (provider.error != null && provider.pokemon == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
                  const SizedBox(height: 16),
                  Text(
                    'ERROR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    provider.error!,
                    style: const TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        if (provider.pokemon == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.catching_pokemon,
                  size: 80,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(height: 16),
                Text(
                  'BUSCAR POKÉMON',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ingresa un nombre en el buscador',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }

        return _buildPokemonDetail(provider.pokemon!);
      },
    );
  }

  Widget _buildPokemonDetail(Pokemon pokemon) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Imagen del Pokémon
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade700, width: 2),
              ),
              child: pokemon.imageUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        pokemon.imageUrl,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(color: Colors.red),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.error, size: 50),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.catching_pokemon, size: 50),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          // Información
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  pokemon.name.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'N.° ${pokemon.id.toString().padLeft(3, '0')}',
                  style: TextStyle(
                    color: Colors.yellow.shade300,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat('ALTURA', '${pokemon.height / 10} m'),
                    _buildStat('PESO', '${pokemon.weight / 10} kg'),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  alignment: WrapAlignment.center,
                  children: pokemon.abilities.map((ability) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.shade700,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        ability.name.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSecondaryScreen() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barra de búsqueda
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.shade700, width: 2),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Buscar Pokémon...',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                    ),
                    onSubmitted: (_) => _searchPokemon(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: _searchPokemon,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Lista de Pokémon
          Expanded(
            child: Consumer<PokemonProvider>(
              builder: (context, provider, child) {
                if (provider.pokemonList.isEmpty && !provider.isLoading) {
                  return Center(
                    child: Text(
                      'No hay Pokémon',
                      style: TextStyle(color: Colors.white70),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: provider.pokemonList.length,
                  itemBuilder: (context, index) {
                    final pokemon = provider.pokemonList[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.red.shade700.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        leading: Icon(
                          Icons.catching_pokemon,
                          color: Colors.red.shade300,
                          size: 20,
                        ),
                        title: Text(
                          pokemon.name.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          _searchController.text = pokemon.name;
                          _searchPokemon();
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Botón A (Buscar)
          _buildControlButton(
            label: 'A',
            icon: Icons.search,
            color: Colors.red.shade700,
            onPressed: _searchPokemon,
          ),
          // Botón B (Cargar más)
          _buildControlButton(
            label: 'B',
            icon: Icons.refresh,
            color: Colors.blue.shade700,
            onPressed: _loadMorePokemons,
          ),
          // Botón C (Limpiar)
          _buildControlButton(
            label: 'C',
            icon: Icons.clear,
            color: Colors.yellow.shade700,
            onPressed: () {
              _searchController.clear();
              context.read<PokemonProvider>().clear();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
