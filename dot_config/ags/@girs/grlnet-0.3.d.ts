/// <reference path="./soup-3.0.d.ts" />
/// <reference path="./gio-2.0.d.ts" />
/// <reference path="./gobject-2.0.d.ts" />
/// <reference path="./glib-2.0.d.ts" />
/// <reference path="./gmodule-2.0.d.ts" />

/**
 * Type Definitions for Gjs (https://gjs.guide/)
 *
 * These type definitions are automatically generated, do not edit them by hand.
 * If you found a bug fix it in `ts-for-gir` or create a bug report on https://github.com/gjsify/ts-for-gir
 *
 * The based EJS template file is used for the generated .d.ts file of each GIR module like Gtk-4.0, GObject-2.0, ...
 */

declare module 'gi://GrlNet?version=0.3' {
    // Module dependencies
    import type Soup from 'gi://Soup?version=3.0';
    import type Gio from 'gi://Gio?version=2.0';
    import type GObject from 'gi://GObject?version=2.0';
    import type GLib from 'gi://GLib?version=2.0';
    import type GModule from 'gi://GModule?version=2.0';

    export namespace GrlNet {
        /**
         * GrlNet-0.3
         */

        /**
         * These constants identify all the available errors managed by
         * the web client.
         */

        /**
         * These constants identify all the available errors managed by
         * the web client.
         */
        export namespace WcError {
            export const $gtype: GObject.GType<WcError>;
        }

        enum WcError {
            /**
             * Deprecated. For generic errors, you
             * should check for G_IO_ERROR_FAILED from G_IO_ERROR domain.
             */
            UNAVAILABLE,
            /**
             * Invalid URI or header
             */
            PROTOCOL_ERROR,
            /**
             * Required authentication
             */
            AUTHENTICATION_REQUIRED,
            /**
             * Request resource not found
             */
            NOT_FOUND,
            /**
             * The entry has been modified since is was
             * downloaded
             */
            CONFLICT,
            /**
             * TBD
             */
            FORBIDDEN,
            /**
             * Cannot connect to the server
             */
            NETWORK_ERROR,
            /**
             * Deprecated. You should check for
             * G_IO_ERROR_PROXY_FAILED from G_IO_ERROR domain.
             */
            PROXY_ERROR,
            /**
             * Deprecated. You should check for
             * G_IO_ERROR_CANCELLED from G_IO_ERROR domain.
             */
            CANCELLED,
        }
        namespace Wc {
            // Constructor properties interface

            interface ConstructorProps extends GObject.Object.ConstructorProps {
                cache: boolean;
                cache_size: number;
                cacheSize: number;
                loglevel: number;
                throttling: number;
                user_agent: string;
                userAgent: string;
            }
        }

        class Wc extends GObject.Object {
            static $gtype: GObject.GType<Wc>;

            // Properties

            get cache(): boolean;
            set cache(val: boolean);
            get cache_size(): number;
            set cache_size(val: number);
            get cacheSize(): number;
            set cacheSize(val: number);
            get loglevel(): number;
            set loglevel(val: number);
            get throttling(): number;
            set throttling(val: number);
            get user_agent(): string;
            set user_agent(val: string);
            get userAgent(): string;
            set userAgent(val: string);

            // Constructors

            constructor(properties?: Partial<Wc.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): Wc;

            // Static methods

            static error_quark(): GLib.Quark;

            // Methods

            /**
             * This method will flush all the pending request in the queue.
             */
            flush_delayed_requests(): void;
            /**
             * Request the fetching of a web resource given the `uri`. This request is
             * asynchronous, thus the result will be returned within the `callback`.
             * @param uri The URI of the resource to request
             * @param cancellable a #GCancellable instance or %NULL to ignore
             */
            request_async(uri: string, cancellable?: Gio.Cancellable | null): Promise<Uint8Array | null>;
            /**
             * Request the fetching of a web resource given the `uri`. This request is
             * asynchronous, thus the result will be returned within the `callback`.
             * @param uri The URI of the resource to request
             * @param cancellable a #GCancellable instance or %NULL to ignore
             * @param callback The callback when the result is ready
             */
            request_async(
                uri: string,
                cancellable: Gio.Cancellable | null,
                callback: Gio.AsyncReadyCallback<this> | null,
            ): void;
            /**
             * Request the fetching of a web resource given the `uri`. This request is
             * asynchronous, thus the result will be returned within the `callback`.
             * @param uri The URI of the resource to request
             * @param cancellable a #GCancellable instance or %NULL to ignore
             * @param callback The callback when the result is ready
             */
            request_async(
                uri: string,
                cancellable?: Gio.Cancellable | null,
                callback?: Gio.AsyncReadyCallback<this> | null,
            ): Promise<Uint8Array | null> | void;
            /**
             * Finishes an asynchronous load of the file's contents.
             * The contents are placed in contents, and length is set to the size of the
             * contents string.
             *
             * The content address will be invalidated at the next request. So if you
             * want to keep it, please copy it into another address.
             * @param result The result of the request
             * @returns %TRUE if the request was successfull. If %FALSE an error occurred.
             */
            request_finish(result: Gio.AsyncResult): [boolean, Uint8Array | null];
            /**
             * Request the fetching of a web resource given the `uri`. This request is
             * asynchronous, thus the result will be returned within the `callback`.
             * @param uri The URI of the resource to request
             * @param headers a set of additional HTTP headers for this request or %NULL to ignore
             * @param cancellable a #GCancellable instance or %NULL to ignore
             * @param callback The callback when the result is ready
             */
            request_with_headers_async(
                uri: string,
                headers?: GLib.HashTable<string, string> | null,
                cancellable?: Gio.Cancellable | null,
                callback?: Gio.AsyncReadyCallback<this> | null,
            ): void;
            /**
             * Sets if cache must be used. Note that this will only work if caching is
             * supporting.  If sets %TRUE, a new cache will be created. If sets to %FALSE,
             * current cache is clean and removed.
             * @param use_cache if cache must be used or not
             */
            set_cache(use_cache: boolean): void;
            /**
             * Sets the new maximum size of cache, in Megabytes. Default value is 10. Using
             * 0 means no cache will be done.
             * @param cache_size size of cache (in Mb)
             */
            set_cache_size(cache_size: number): void;
            /**
             * Setting the log level the logger feature is added into
             * the libsoup session.
             * @param log_level the libsoup log level to set [0,3]
             */
            set_log_level(log_level: number): void;
            /**
             * Setting this property, the #GrlNetWc will queue all the requests and
             * will dispatch them with a pause between them of this value.
             *
             * Note that if the grl-net library was compiled against libsoup3, changing
             * the throttling configuration will show a warning if done after the first
             * request.
             * @param throttling the number of seconds to wait between requests
             */
            set_throttling(throttling: number): void;
        }

        type WcClass = typeof Wc;
        abstract class WcPrivate {
            static $gtype: GObject.GType<WcPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        /**
         * Name of the imported GIR library
         * `see` https://gitlab.gnome.org/GNOME/gjs/-/blob/master/gi/ns.cpp#L188
         */
        const __name__: string;
        /**
         * Version of the imported GIR library
         * `see` https://gitlab.gnome.org/GNOME/gjs/-/blob/master/gi/ns.cpp#L189
         */
        const __version__: string;
    }

    export default GrlNet;
}

declare module 'gi://GrlNet' {
    import GrlNet03 from 'gi://GrlNet?version=0.3';
    export default GrlNet03;
}
// END
