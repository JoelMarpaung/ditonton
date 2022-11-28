import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/models/season_detail_model.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:tv/domain/entities/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tTvModel = TvModel(
    backdropPath: '/path.jpg',
    genreIds: [14, 28],
    id: 557,
    overview: 'overview',
    popularity: 60.441,
    posterPath: '/path.jpg',
    voteAverage: 7.2,
    voteCount: 13507,
    originalLanguage: '',
    name: '',
    originalName: '',
  );

  final tTv = Tv(
    backdropPath: '/path.jpg',
    genreIds: const [14, 28],
    id: 557,
    overview: 'overview',
    popularity: 60.441,
    posterPath: '/path.jpg',
    voteAverage: 7.2,
    voteCount: 13507,
    originalLanguage: '',
    name: '',
    originalName: '',
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('Now Playing Tvs', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvs())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getNowPlayingTvs();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvs());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvs())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTvs();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvs());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvs())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTvs();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvs());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingTvs())
              .thenThrow(const TlsException('CERTIFICATE_VERIFY_FAILED'));
          // act
          final result = await repository.getNowPlayingTvs();
          // assert
          verify(mockRemoteDataSource.getNowPlayingTvs());
          expect(
              result,
              equals(const Left(
                  SSLFailure('CERTIFICATE_VERIFY_FAILED'))));
        });
  });

  group('Popular Tvs', () {
    test('should return Tv list when call to data source is success', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvs())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getPopularTvs();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvs()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvs();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvs())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvs();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvs())
              .thenThrow(const TlsException('CERTIFICATE_VERIFY_FAILED'));
          // act
          final result = await repository.getPopularTvs();
          // assert
          expect(result,
              const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
        });
  });

  group('Top Rated Tvs', () {
    test('should return Tv list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvs())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTopRatedTvs();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvs()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvs();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvs())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvs();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvs())
              .thenThrow(const TlsException('CERTIFICATE_VERIFY_FAILED'));
          // act
          final result = await repository.getTopRatedTvs();
          // assert
          expect(result,
              const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
        });
  });

  group('Get Tv Detail', () {
    const tId = 1;
    const tTvResponse = TvDetailResponse(
        posterPath: '',
        popularity: 0,
        id: 0,
        backdropPath: '',
        voteAverage: 0,
        overview: '',
        originalLanguage: '',
        voteCount: 0,
        name: '',
        originalName: '',
        genres: [],
        seasons: []);

    test(
        'should return Tv data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId))
          .thenAnswer((_) async => tTvResponse);
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Right(testTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvDetail(tId))
              .thenThrow(const TlsException('CERTIFICATE_VERIFY_FAILED'));
          // act
          final result = await repository.getTvDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvDetail(tId));
          expect(
              result,
              equals(const Left(
                  SSLFailure('CERTIFICATE_VERIFY_FAILED'))));
        });
  });

  group('Get Tv Recommendations', () {
    final tTvList = <TvModel>[];
    const tId = 1;

    test('should return data (Tv list) when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => tTvList);
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvRecommendations(tId))
              .thenThrow(const TlsException('CERTIFICATE_VERIFY_FAILED'));
          // act
          final result = await repository.getTvRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getTvRecommendations(tId));
          expect(
              result,
              equals(const Left(
                  SSLFailure('CERTIFICATE_VERIFY_FAILED'))));
        });
  });

  group('Search Tvs', () {
    const tQuery = 'game of throne';

    test('should return Tv list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvs(tQuery))
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.searchTvs(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvs(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTvs(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvs(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvs(tQuery);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvs(tQuery))
              .thenThrow(const TlsException('CERTIFICATE_VERIFY_FAILED'));
          // act
          final result = await repository.searchTvs(tQuery);
          // assert
          expect(result,
              const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
        });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist Tvs', () {
    test('should return list of Tvs', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvs())
          .thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getWatchlistTvs();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchListTv]);
    });
  });

  group('Get Season Detail', () {
    const tId = 3624;
    const tSeasonNumber = 1;
    const tSeason = SeasonDetailModel(
        posterPath: '',
        id: 0,
        overview: '',
        name: '',
        seasonNumber: 1,
        episodes: []);

    test(
        'should return season data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber))
          .thenAnswer((_) async => tSeason);
      // act
      final result = await repository.getSeasonDetail(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber));
      expect(result, equals(const Right(testSeasonDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber))
          .thenThrow(ServerException());
      // act
      final result = await repository.getSeasonDetail(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber));
      expect(result, equals(const Left(ServerFailure(''))));
    });
    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSeasonDetail(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber))
              .thenThrow(const TlsException('CERTIFICATE_VERIFY_FAILED'));
          // act
          final result = await repository.getSeasonDetail(tId, tSeasonNumber);
          // assert
          verify(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber));
          expect(
              result,
              equals(const Left(
                  SSLFailure('CERTIFICATE_VERIFY_FAILED'))));
        });
  });
}
