import { App, Astal, Gtk } from "astal/gtk3";
import Mpris from "gi://AstalMpris";
import { bind, Variable } from "astal";

function lengthStr(length: number) {
  const min = Math.floor(length / 60);
  const sec = Math.floor(length % 60);
  const sec0 = sec < 10 ? "0" : "";
  return `${min}:${sec0}${sec}`;
}

function MediaPlayer({
  player,
  exiting,
}: {
  player: Mpris.Player;
  exiting: Variable<boolean>;
}) {
  const { START, END } = Gtk.Align;

  const title = bind(player, "title").as((t) => t || "Unknown Track");

  const artist = bind(player, "artist").as((a) => a || "Unknown Artist");

  const coverArt = bind(player, "coverArt").as(
    (c) => `background-image: url('${c}')`,
  );

  const playerIcon = bind(player, "entry").as((e) => {
    if (e == null) {
      return "audio-x-generic-symbolic";
    }
    Astal.Icon.lookup_icon(e) ? e : "audio-x-generic-symbolic";
  });

  const position = bind(player, "position").as((p) =>
    player.length > 0 ? p / player.length : 0,
  );

  const volume = bind(player, "volume").as((v) => v);

  const playIcon = bind(player, "playbackStatus").as((s) =>
    s === Mpris.PlaybackStatus.PLAYING
      ? "media-playback-pause-symbolic"
      : "media-playback-start-symbolic",
  );

  return (
    <box
      className={bind(exiting).as(
        (exiting) => `MediaPlayer ${exiting ? "BotTopAnim" : "TopBotAnim"}`,
      )}
    >
      <box className="cover-art" css={coverArt} />
      <box vertical>
        <box className="title">
          <label truncate hexpand halign={START} label={title} />
          <icon icon={playerIcon} />
        </box>
        <label halign={START} valign={START} vexpand wrap label={artist} />
        <box spacing={10}>
          <icon icon="audio-on-symbolic"></icon>
          <slider
            visible={bind(player, "volume").as((l) => l > 0)}
            min={0}
            max={1}
            onDragged={({ value }) => (player.volume = value)}
            value={volume}
            hexpand
          />
        </box>
        <box spacing={10}>
          <icon icon="media-playback-start-symbolic"></icon>
          <slider
            visible={bind(player, "length").as((l) => l > 0)}
            min={0}
            max={1}
            hexpand
            onDragged={({ value }) => (player.position = player.length * value)}
            value={position}
          />
        </box>

        <centerbox className="actions">
          <label
            hexpand
            className="position"
            halign={START}
            visible={bind(player, "length").as((l) => l > 0)}
            label={bind(player, "position").as(lengthStr)}
          />
          <box>
            <button
              onClicked={() => player.previous()}
              visible={bind(player, "canGoPrevious")}
            >
              <icon icon="media-skip-backward-symbolic" />
            </button>
            <button
              onClicked={() => player.play_pause()}
              visible={bind(player, "canControl")}
            >
              <icon icon={playIcon} />
            </button>
            <button
              onClicked={() => player.next()}
              visible={bind(player, "canGoNext")}
            >
              <icon icon="media-skip-forward-symbolic" />
            </button>
          </box>
          <label
            className="length"
            hexpand
            halign={END}
            visible={bind(player, "volume").as((l) => l > 0)}
            label={bind(player, "volume").as((l) =>
              l > 0 ? l.toPrecision(3).toString() : "0",
            )}
          />
        </centerbox>
      </box>
    </box>
  );
}

export default function MprisPlayers() {
  const mpris = Mpris.get_default();
  const exiting = Variable(false);
  const exit = () => {
    exiting.set(true);
    // console.log(exiting.get());
    setTimeout(() => {
      App.quit();
    }, 300);
  };
  const { TOP, LEFT } = Astal.WindowAnchor;
  return (
    <window anchor={TOP | LEFT} margin_left={180}>
      <box vertical>
        {bind(mpris, "players").as((arr) => {
          // arr.forEach((player) => {
          //   console.log("==================================");
          //   console.log(player.trackid);
          //   console.log("==================================");
          // });
          const uniqueArr = Array.from(
            new Map(
              arr
                .filter((it) => it.artist || it.title)
                .map((it) => [it.trackid, it]),
            ).values(),
          );
          return uniqueArr.map((player) => (
            <MediaPlayer player={player} exiting={exiting} />
          ));
        })}
        <centerbox className="actions">
          <box></box>
          <box></box>
          <box>
            <button onClicked={exit}>
              <icon icon="window-close-symbolic" />
            </button>
          </box>
        </centerbox>
      </box>
    </window>
  );
}
