CLASS zcl_itab_nesting DEFINITION    "Start of the class definition for zcl_itab_nesting
  PUBLIC                             "The class is publicly accessible
  FINAL                              "The class cannot be inherited
  CREATE PUBLIC .                    "Allows public creation of instances

  PUBLIC SECTION.  " Public section of the class where types and methods are declared

    " Definition of the structure for the ARTISTS internal table
    TYPES: BEGIN OF artists_type,    
             artist_id   TYPE string,     "Field for artist ID
             artist_name TYPE string,     "Field for artist name
           END OF artists_type.
    TYPES artists TYPE STANDARD TABLE OF artists_type WITH KEY artist_id. "Definition of the ARTISTS internal table with a unique key on artist_id

    " Definition of the structure for the ALBUMS internal table
    TYPES: BEGIN OF albums_type,     
             artist_id  TYPE string,      "Field for artist ID (foreign key)
             album_id   TYPE string,      "Field for album ID
             album_name TYPE string,      "Field for album name
           END OF albums_type.
    TYPES albums TYPE STANDARD TABLE OF albums_type WITH KEY artist_id album_id. "Definition of the ALBUMS internal table with composite keys on artist_id and album_id

    " Definition of the structure for the SONGS internal table
    TYPES: BEGIN OF songs_type,      
             artist_id TYPE string,       "Field for artist ID (foreign key)
             album_id  TYPE string,       "Field for album ID (foreign key)
             song_id   TYPE string,       "Field for song ID
             song_name TYPE string,       "Field for song name
           END OF songs_type.
    TYPES songs TYPE STANDARD TABLE OF songs_type WITH KEY artist_id album_id song_id. "Definition of the SONGS internal table with composite keys on artist_id, album_id, and song_id

    " Definition of the nested structure for SONGS
    TYPES: BEGIN OF song_nested_type,
             song_id   TYPE string,       "Field for song ID in nested structure
             song_name TYPE string,       "Field for song name in nested structure
           END OF song_nested_type.

    " Definition of the nested structure for ALBUMS with songs
    TYPES: BEGIN OF album_song_nested_type,
             album_id   TYPE string,      "Field for album ID in nested structure
             album_name TYPE string,      "Field for album name in nested structure
             songs      TYPE STANDARD TABLE OF song_nested_type WITH KEY song_id, "Internal table for nested songs
           END OF album_song_nested_type.

    " Definition of the nested structure for ARTISTS with albums
    TYPES: BEGIN OF artist_album_nested_type,
             artist_id   TYPE string,     "Field for artist ID in nested structure
             artist_name TYPE string,     "Field for artist name in nested structure
             albums      TYPE STANDARD TABLE OF album_song_nested_type WITH KEY album_id, "Internal table for nested albums
           END OF artist_album_nested_type.
    
    " Definition of the final nested data structure
    TYPES nested_data TYPE STANDARD TABLE OF artist_album_nested_type WITH KEY artist_id.

    " Method to perform the nesting operation
    METHODS perform_nesting
      IMPORTING
        artists            TYPE artists    "Input internal table of artists
        albums             TYPE albums     "Input internal table of albums
        songs              TYPE songs      "Input internal table of songs
      RETURNING
        VALUE(nested_data) TYPE nested_data. "Returns the nested data structure

  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION.   " Private section of the class (not used here)
ENDCLASS.            " End of class definition

" Begin implementation of the class zcl_itab_combination
CLASS zcl_itab_nesting IMPLEMENTATION.
  " Performs the actual task of nesting the data from the three input tables (artists, albums, and songs) into a single nested data structure.
  " It uses the ABAP constructor operator VALUE #(...) to create nested internal tables:
  " First Loop (FOR artist IN artists): Iterates over each artist to create entries in the nested_data table.
  " Second Loop (FOR album IN albums): Filters and iterates over albums corresponding to the current artist.
  " Third Loop (FOR song IN songs): Filters and iterates over songs corresponding to the current album and artist.
  " The WHERE clause in each loop ensures that the correct relational data is nested under each artist and album."
  METHOD perform_nesting.
    " Begin the creation of nested data by iterating over each artist in the artists table
    nested_data = VALUE #(
                    FOR artist IN artists
                    (
                        artist_id = artist-artist_id             "Set artist_id in the nested data structure
                        artist_name = artist-artist_name         "Set artist_name in the nested data structure
                        albums = VALUE #(                        "Create nested albums for each artist
                            FOR album IN albums
                            WHERE ( artist_id = artist-artist_id ) "Filter albums matching the current artist
                            (
                                album_id =  album-album_id       "Set album_id in the nested album structure
                                album_name =  album-album_name   "Set album_name in the nested album structure
                                songs = VALUE #(                 "Create nested songs for each album
                                    FOR song IN songs
                                    WHERE                        "Filter songs matching the current artist and album
                                        ( artist_id = artist-artist_id
                                        AND album_id = album-album_id )
                                    (
                                        song_id = song-song_id   "Set song_id in the nested song structure
                                        song_name = song-song_name "Set song_name in the nested song structure
                                    )
                                )
                            )
                        )
                    )
                ).
  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation

