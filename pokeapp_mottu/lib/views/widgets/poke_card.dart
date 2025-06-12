import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokeapp_mottu/models/pokemon.dart';


class PokeCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;

  const PokeCard({
    super.key,
    required this.pokemon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CachedNetworkImage(
                  imageUrl: pokemon.imageUrl,
                  height: 80,
                  width: 80,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Text(
                  pokemon.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}