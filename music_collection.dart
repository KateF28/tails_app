// Create a _Song class with a name, singer, duration, and releaseYear properties
final class _Song {
  String name;
  String singer;
  Duration duration;
  int releaseYear;

  _Song(this.name, this.singer, this.duration, this.releaseYear);
}

// Create _Playlist class with name and songs properties which can contain any number of songs
interface class _Playlist with _SearchMixin {
  String name;
  List<_Song> songs;

  _Playlist(this.name, this.songs);
}

// Create mixin _SearchMixin with a song search on _Playlist by name or singer property method which filters songs by text
mixin _SearchMixin {
  List<_Song> search(String text, List<_Song> songs) {
    return songs.where((song) => song.name.contains(text) || song.singer.contains(text)).toList();
  }
}

// Create extension on Duration with method to stringify it
extension _Stringify on Duration {
  String stringify() => '${inHours == 0 ? '' : '$inHours:'}${inMinutes.remainder(60).toString().padLeft(2, '0')}:${inSeconds.remainder(60).toString().padLeft(2, '0')}';
}
// Create extension on List<_Song> with method to get total duration of songs
const Duration _initialTotalDuration = Duration.zero;
extension _GetTotalDuration on List<_Song> {
  Duration getTotalDuration() => fold<Duration>(_initialTotalDuration, (sum, song) => sum + song.duration);
}
// Create extension on List<_Song> with method to stringify it
extension _StringifySongs on List<_Song> {
  String stringify() => map((song) => '${indexOf(song) + 1}. \'${song.name}\' by ${song.singer} - ${song.duration.inMinutes}:${song.duration.inSeconds.remainder(60).toString().padLeft(2, '0')} (${song.releaseYear})').join('\n');
}

void main() {
  // Create _playlist with songs collection with up to 30 songs, print it out in formatted way
  final _Playlist playlist = _Playlist('New playlist', [
    _Song('Bohemian Rhapsody', 'Queen', const Duration(minutes: 5, seconds: 55), 1975),
    _Song('Somebody to Love', 'Queen', const Duration(minutes: 4, seconds: 56), 1976),
    _Song('Don\'t Stop Me Now', 'Queen', const Duration(minutes: 3, seconds: 29), 1978),
    _Song('Radio Ga Ga', 'Queen', const Duration(minutes: 5, seconds: 49), 1984),
    _Song('We Will Rock You', 'Queen', const Duration(minutes: 2, seconds: 2), 1977),
    _Song('We Are the Champions', 'Queen', const Duration(minutes: 3, seconds: 1), 1977),
    _Song('Killer Queen', 'Queen', const Duration(minutes: 3), 1974),
    _Song('Innuendo', 'Queen', const Duration(minutes: 6, seconds: 31), 1991),
    _Song('Crazy Little Thing Called Love', 'Queen', const Duration(minutes: 2, seconds: 44), 1979),
    _Song('Under Pressure', 'Queen', const Duration(minutes: 4, seconds: 5), 1981),
    _Song('Love of My Life', 'Queen', const Duration(minutes: 3, seconds: 38), 1975),
    _Song('The Show Must Go On', 'Queen', const Duration(minutes: 4, seconds: 31), 1991),
    _Song('I Want to Break Free', 'Queen', const Duration(minutes: 4, seconds: 18), 1984),
    _Song('A Kind of Magic', 'Queen', const Duration(minutes: 4, seconds: 23), 1986),
    _Song('Who Wants to Live Forever', 'Queen', const Duration(minutes: 5, seconds: 15), 1986),
    _Song('The Great Pretender', 'Queen', const Duration(minutes: 3, seconds: 29), 1987),
    _Song('Too Much Love Will Kill You', 'Queen', const Duration(minutes: 4, seconds: 20), 1995),
    _Song('I Was Born to Love You', 'Queen', const Duration(minutes: 4, seconds: 49), 1985),
    _Song('Radioactive', 'Imagine Dragons', const Duration(minutes: 3, seconds: 7), 2012),
    _Song('Demons', 'Imagine Dragons', const Duration(minutes: 2, seconds: 57), 2012),
    _Song('Believer', 'Imagine Dragons', const Duration(minutes: 3, seconds: 24), 2017),
    _Song('Thunder', 'Imagine Dragons', const Duration(minutes: 3, seconds: 7), 2017),
    _Song('It\'s Time', 'Imagine Dragons', const Duration(minutes: 4), 2012),
    _Song('Whatever It Takes', 'Imagine Dragons', const Duration(minutes: 3, seconds: 21), 2017),
    _Song('Natural', 'Imagine Dragons', const Duration(minutes: 3, seconds: 9), 2018),
    _Song('On Top of the World', 'Imagine Dragons', const Duration(minutes: 3, seconds: 12), 2012),
    _Song('Warriors', 'Imagine Dragons', const Duration(minutes: 2, seconds: 51), 2014),
    _Song('I Bet My Life', 'Imagine Dragons', const Duration(minutes: 3, seconds: 14), 2014)
  ]);
  print('Playlist \'${playlist.name}\':\n${playlist.songs.stringify()}\n');

  // Search songs by name and print them and their total duration
  final List<_Song> playlistBySongName = playlist.search('Thunder', playlist.songs);
  final Duration playlistBySongNameTotalDuration = playlistBySongName.getTotalDuration();
  print('Playlist searched by song name:\n${playlistBySongName.stringify()}');
  print('Duration of playlist searched by song name is ${playlistBySongNameTotalDuration.stringify()}\n');

  // Search songs by singer and print them and their total duration
  final List<_Song> playlistBySinger = playlist.search('Queen', playlist.songs);
  final Duration playlistBySingerTotalDuration = playlistBySinger.getTotalDuration();
  print('Playlist searched by singer:\n${playlistBySinger.stringify()}');
  print('Duration of playlist searched by singer is ${playlistBySingerTotalDuration.stringify()}');
}
