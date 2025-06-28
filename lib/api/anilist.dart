import 'dart:convert';

import 'package:http/http.dart' as http;

class Anilist {
  final String _baseURL = 'https://graphql.anilist.co';

  Anilist();

  Future<List> getPopularAnime(int page, int perPage) async {
    String query = '''
      query Page(\$page: Int, \$perPage: Int) {
  Page(page: \$page, perPage: \$perPage) {
    media(sort: [POPULARITY_DESC,SCORE_DESC], type: ANIME, format_not_in: [MOVIE]) {
      id
      title {
        romaji
        english
        native
        userPreferred
      }
      coverImage {
        extraLarge
        large
        medium
        color
      }
    }
  }
}
    ''';

    try {
      var response = await http.post(
        Uri.parse(_baseURL),
        body: jsonEncode({
          'query': query,
          'variables': {'page': page, 'perPage': perPage},
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      return jsonDecode(response.body)['data']['Page']['media'];
    } catch (e) {
      return [];
    }
  }

  Future<dynamic> getMediaInfo(int mediaId) async {
    final String query = '''
      query Media(\$mediaId: Int) {
  Media(id: \$mediaId) {
    id
    idMal
    title {
      romaji
      english
      native
      userPreferred
    }
    type
    format
    status
    description
    startDate {
      year
      month
      day
    }
    endDate {
      year
      month
      day
    }
    season
    seasonYear
    episodes
    duration
    chapters
    volumes
    countryOfOrigin
    isLicensed
    source
    hashtag
    trailer {
      id
      site
      thumbnail
    }
    updatedAt
    coverImage {
      extraLarge
      large
      medium
      color
    }
    bannerImage
    genres
    synonyms
    averageScore
    meanScore
    popularity
    isLocked
    trending
    favourites
    tags {
      id
      name
    }
    relations {
      edges {
        relationType
        node {
          id
          title {
            romaji
            english
            native
            userPreferred
          }
          coverImage {
            extraLarge
            large
            medium
            color
          }
        }
      }
    }
    characters {
      nodes {
        id
        name {
          first
          middle
          last
          full
          native
          alternative
          alternativeSpoiler
          userPreferred
        }
        image {
          large
          medium
        }
        description
        gender
        dateOfBirth {
          year
          month
          day
        }
        age
      }
    }
    staff {
      nodes {
        id
        name {
          first
          middle
          last
          full
          native
          alternative
          userPreferred
        }
        image {
          large
          medium
        }
        description
        gender
        dateOfBirth {
          year
          month
          day
        }
        age
      }
    }
    studios {
      nodes {
        id
        name
        isAnimationStudio
      }
    }
    isFavourite
    isFavouriteBlocked
    isAdult
    nextAiringEpisode {
      id
      airingAt
      timeUntilAiring
      episode
      mediaId
    }
    airingSchedule {
      nodes {
        id
        airingAt
        timeUntilAiring
        episode
        mediaId
      }
    }
    streamingEpisodes {
      thumbnail
      title
      url
    }
  }
}
    ''';

    var response = await http.post(
      Uri.parse(_baseURL),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'query': query,
        'variables': {'mediaId': mediaId},
      }),
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body)['data']['Media'];
      return body;
    } else {
      return null;
    }
  }
}
